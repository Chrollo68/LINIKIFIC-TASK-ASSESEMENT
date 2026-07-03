# Supabase Integration Guide for FitFlow

## Overview
This guide explains how to set up and use Supabase authentication and database integration with the FitFlow fitness tracker application.

## Prerequisites
- Supabase account (free tier available at https://supabase.com)
- Flutter development environment
- Understanding of REST APIs

## Step 1: Create a Supabase Project

1. Go to https://supabase.com and sign up/log in
2. Click "New Project" button
3. Fill in the project details:
   - **Name**: `fitness-track` (or your preferred name)
   - **Database Password**: Create a strong password
   - **Region**: Select closest to your location
   - **Pricing Plan**: Select "Free" for development
4. Click "Create new project"
5. Wait for the project to be created (this may take a few minutes)

## Step 2: Get Your Supabase Credentials

Once your project is created:

1. Go to **Project Settings** → **API**
2. Copy the following values:
   - **Project URL**: This is your `SUPABASE_URL`
   - **anon public key**: This is your `SUPABASE_ANON_KEY`
3. Keep these values safe - you'll need them in the next step

## Step 3: Configure Supabase in the App

1. Open `lib/config/supabase_config.dart`
2. Replace the placeholder values:
```dart
static const String supabaseUrl = 'https://your-project.supabase.co';
static const String supabaseAnonKey = 'your-anon-key';
```

With your actual values:
```dart
static const String supabaseUrl = 'https://your-project-id.supabase.co';
static const String supabaseAnonKey = 'your-actual-anon-key-here';
```

## Step 4: Create Database Tables

1. In the Supabase dashboard, go to **SQL Editor**
2. Click "New Query"
3. Copy and paste the SQL commands below:

### Create Users Table
```sql
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on email for faster lookups
CREATE INDEX idx_users_email ON users(email);
```

### Create Workouts Table
```sql
CREATE TABLE workouts (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  duration INTEGER NOT NULL,
  calories INTEGER NOT NULL,
  date DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on user_id for faster queries
CREATE INDEX idx_workouts_user_id ON workouts(user_id);

-- Create index on date for filtering by date
CREATE INDEX idx_workouts_date ON workouts(date);
```

4. Click "Run" to execute the queries

## Step 5: Enable Row Level Security (RLS)

For production applications, enable Row Level Security:

1. Go to **Authentication** → **Policies**
2. For the `users` table:
   - Click "New Policy"
   - Policy: "SELECT policy"
   - Target roles: authenticated
   - Using clause: `auth.uid()::text = id`
3. For the `workouts` table:
   - Create similar policies to ensure users can only see their own workouts

**Note**: For development/testing, you can skip RLS, but it's recommended for production.

## Step 6: Install Dependencies

The required dependencies are already added to `pubspec.yaml`:
```yaml
supabase_flutter: ^2.0.0
supabase: ^2.0.0
crypto: ^3.0.0
```

Run:
```bash
flutter pub get
```

## Step 7: Initialize Supabase in Your App

The app initializes Supabase in the `main.dart` file. Make sure it's set up properly:

```dart
import 'package:fitness_track/config/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await SupabaseConfig.initialize();
  
  runApp(const MyApp());
}
```

## Features Included

### Authentication
- Email/password registration
- Email/password login
- User profile updates
- Error handling with user-friendly messages
- Password hashing using SHA256

### Workout Management
- Add workouts with title, duration, calories, and date
- Update existing workouts
- Delete workouts
- View all workouts for a user
- View workouts by specific date
- Track total calories burned
- Calculate average workout duration

### Data Models

#### User Model
```
- id: Integer (unique identifier)
- name: String
- email: String (unique)
- password: String (hashed)
- created_at: Timestamp
- updated_at: Timestamp
```

#### Workout Model
```
- id: Integer (unique identifier)
- user_id: Integer (references users.id)
- title: String
- duration: Integer (in minutes)
- calories: Integer
- date: Date
- created_at: Timestamp
```

## Usage Examples

### Login
```dart
final authProvider = Provider.of<AuthProvider>(context, listen: false);
final success = await authProvider.login('user@example.com', 'password123');
if (success) {
  print('Login successful');
}
```

### Register
```dart
final authProvider = Provider.of<AuthProvider>(context, listen: false);
final success = await authProvider.register(
  'John Doe',
  'john@example.com',
  'password123'
);
if (success) {
  print('Registration successful');
}
```

### Add Workout
```dart
final workoutProvider = Provider.of<SupabaseWorkoutProvider>(context, listen: false);
await workoutProvider.addWorkout(
  userId: authProvider.user!.id,
  title: 'Morning Run',
  duration: 30,
  calories: 250,
  date: DateTime.now(),
);
```

### Load User Workouts
```dart
final workoutProvider = Provider.of<SupabaseWorkoutProvider>(context, listen: false);
await workoutProvider.loadWorkouts(authProvider.user!.id);
```

## Error Handling

The app includes comprehensive error handling:
- Network errors are caught and displayed to users
- Email validation before registration
- Password strength validation (minimum 6 characters)
- Duplicate email detection
- Fallback to local authentication for offline support

## Security Considerations

1. **Password Hashing**: Passwords are hashed using SHA256
   - For production, use bcrypt (add `bcrypt` package)
   
2. **Environment Variables**: 
   - Never commit credentials to version control
   - Consider using environment files or platform-specific configuration

3. **HTTPS**: Supabase uses HTTPS for all API calls

4. **Row Level Security**: Recommended for production deployments

## Troubleshooting

### "Connection refused" error
- Check your Supabase URL and keys are correct
- Ensure the Supabase project is active

### "Column does not exist" error
- Verify all tables and columns are created correctly
- Check SQL syntax in the database

### "Email already exists" error
- The email is already registered
- Try logging in instead or use a different email

### Flutter app crashes on startup
- Ensure Supabase is initialized in main.dart
- Check that all dependencies are installed with `flutter pub get`

## Fallback Mode

The app includes fallback authentication that works without Supabase:
- Useful for development/testing
- Uses local in-memory storage
- Seamlessly switches to Supabase when available

## Next Steps

1. Set up authentication error logging
2. Implement email verification
3. Add password reset functionality
4. Set up automated backups
5. Configure webhook for notifications
6. Add analytics tracking

## Resources

- Supabase Documentation: https://supabase.com/docs
- Flutter Supabase Package: https://pub.dev/packages/supabase_flutter
- Flutter Provider Package: https://pub.dev/packages/provider
