# FitFlow - Supabase Integration Implementation Guide

## Project Structure Overview

```
lib/
├── config/
│   └── supabase_config.dart          # Supabase configuration
├── models/
│   ├── user_model.dart               # User data model (id: int, name, email, password)
│   ├── workout_model.dart            # Workout data model (id: int, user_id, title, duration, calories, date)
│   └── progress_model.dart           # Progress tracking model
├── services/
│   ├── auth_service.dart             # Authentication service (Supabase + fallback)
│   ├── supabase_auth_service.dart    # Supabase-specific auth
│   ├── workout_service.dart          # Local workout service
│   └── supabase_workout_service.dart # Supabase workout database service
├── providers/
│   ├── auth_provider.dart            # Authentication provider with error handling
│   ├── workout_provider.dart         # Local workout provider
│   ├── theme_provider.dart           # Theme provider
│   └── supabase_workout_provider.dart # Supabase workout provider
├── screens/
│   ├── auth/
│   │   └── auth_screen.dart          # Updated with Supabase support
│   └── workouts/
│       └── add_workout_screen.dart   # New screen for adding/editing workouts
└── widgets/
    ├── custom_text_field.dart        # Custom text input
    └── primary_button.dart           # Custom button
```

## Database Schema

### Users Table
```sql
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**Fields:**
- `id` (Integer): Unique user identifier
- `name` (String): User's full name
- `email` (String): User's email (unique)
- `password` (String): SHA256 hashed password
- `created_at` (Timestamp): Account creation time
- `updated_at` (Timestamp): Last update time

### Workouts Table
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
```

**Fields:**
- `id` (Integer): Unique workout identifier
- `user_id` (Integer): References the user who created the workout
- `title` (String): Workout name (e.g., "Morning Run")
- `duration` (Integer): Duration in minutes
- `calories` (Integer): Calories burned
- `date` (Date): When the workout was performed
- `created_at` (Timestamp): Record creation time

## Authentication Flow

### User Registration
```
1. User enters: name, email, password
2. AuthProvider.register() is called
3. Validation checks:
   - Name is not empty
   - Email is valid format
   - Password is at least 6 characters
   - Email doesn't already exist
4. Password is hashed using SHA256
5. User record inserted into Supabase
6. User object returned and stored in Provider
```

### User Login
```
1. User enters: email, password
2. AuthProvider.login() is called
3. Password is hashed
4. Query Supabase for matching email + password
5. If found, user is authenticated
6. User data stored in Provider
7. Navigation to home screen
```

### Error Handling
```
AuthProvider tracks error messages:
- "Invalid email or password" → Login failed
- "Email already registered" → Registration failed
- "Enter a valid email address" → Validation error
- "Password must be at least 6 characters" → Validation error
- Network errors are displayed to user
```

## Workout Management Flow

### Adding a Workout
```
1. User opens Add Workout screen
2. Enters: title, duration (minutes), calories, date
3. SupabaseWorkoutProvider.addWorkout() called
4. Data sent to Supabase workouts table
5. New workout returned with generated ID
6. Added to local workouts list
7. Progress statistics updated
```

### Viewing Workouts
```
1. SupabaseWorkoutProvider.loadWorkouts(userId) called
2. Fetches all workouts from Supabase for user
3. Workouts displayed in chronological order
4. Progress stats calculated:
   - Total workouts completed
   - Total calories for today
   - Average workout duration
```

### Updating Workouts
```
1. User selects a workout to edit
2. Form pre-fills with existing data
3. User modifies fields
4. SupabaseWorkoutProvider.updateWorkout() called
5. Supabase record updated
6. Local list refreshed
```

### Deleting Workouts
```
1. User confirms deletion
2. SupabaseWorkoutProvider.deleteWorkout() called
3. Supabase record deleted
4. Removed from local list
5. Progress stats recalculated
```

## Key Features Implemented

### ✅ Email Authentication
- Registration with email validation
- Login with email/password
- Password hashing (SHA256)
- Error handling for invalid credentials
- Email uniqueness checking

### ✅ User Management
- User profile storage
- User-specific data isolation
- Profile updates
- User authentication state tracking

### ✅ Workout Database
- Create, read, update, delete operations
- Date-based filtering
- User-specific workout queries
- Automatic timestamps

### ✅ Data Validation
- Email format validation
- Password length validation
- Numeric input validation (duration, calories)
- Required field validation

### ✅ Error Handling
- Network error handling
- Validation error messages
- User-friendly error display
- Fallback to local authentication

### ✅ State Management
- Provider for authentication state
- Provider for workout management
- Error state tracking
- Loading state tracking

## Configuration Steps

### 1. Set Up Supabase Project
```
Visit: https://supabase.com/dashboard
1. Create new project
2. Note Project URL and Anon Key
3. Create SQL tables (see Database Schema above)
```

### 2. Update Configuration File
Edit `lib/config/supabase_config.dart`:
```dart
static const String supabaseUrl = 'your-project-url';
static const String supabaseAnonKey = 'your-anon-key';
```

### 3. Add Dependencies
All dependencies are in `pubspec.yaml`:
```yaml
supabase_flutter: ^2.0.0
supabase: ^2.0.0
crypto: ^3.0.0
```

### 4. Initialize in main.dart
```dart
import 'package:fitness_track/config/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();
  runApp(const MyApp());
}
```

## Usage Examples

### Example 1: Register a New User
```dart
final authProvider = context.read<AuthProvider>();

final success = await authProvider.register(
  'John Doe',
  'john@example.com',
  'password123'
);

if (success) {
  print('Registration successful!');
  print('User ID: ${authProvider.user!.id}');
} else {
  print('Error: ${authProvider.errorMessage}');
}
```

### Example 2: Login User
```dart
final success = await authProvider.login(
  'john@example.com',
  'password123'
);

if (success) {
  print('Logged in as: ${authProvider.user!.name}');
} else {
  print('Login failed: ${authProvider.errorMessage}');
}
```

### Example 3: Add a Workout
```dart
final workoutProvider = context.read<SupabaseWorkoutProvider>();

final workout = await workoutProvider.addWorkout(
  userId: authProvider.user!.id,
  title: 'Morning Run',
  duration: 30,
  calories: 250,
  date: DateTime.now(),
);

if (workout != null) {
  print('Workout added: ${workout.title}');
}
```

### Example 4: Load User Workouts
```dart
await workoutProvider.loadWorkouts(authProvider.user!.id);

final workouts = workoutProvider.workouts;
print('Total workouts: ${workouts.length}');

// Access progress stats
print('Calories today: ${workoutProvider.progress.calories}');
print('Workouts completed: ${workoutProvider.progress.workoutsCompleted}');
```

### Example 5: Load Today's Workouts
```dart
await workoutProvider.loadTodayWorkouts(userId);

final todayWorkouts = workoutProvider.todayWorkouts;
for (var workout in todayWorkouts) {
  print('${workout.title}: ${workout.calories} cal');
}
```

## Security Best Practices

1. **Password Hashing**: Use SHA256 (current) or bcrypt (recommended for production)
2. **HTTPS**: All Supabase connections use HTTPS
3. **Environment Variables**: Store credentials in environment files
4. **Row Level Security**: Enable RLS policies in production
5. **Input Validation**: All user inputs are validated before submission

## Performance Optimization

- Indexes created on frequently queried columns (email, user_id, date)
- Efficient pagination available for large workout lists
- Caching through Provider state management
- Lazy loading of user-specific data

## Testing Credentials

For testing/development, use:
- Email: admin@gmail.com
- Password: 123456 (from local fallback)

These credentials work with local authentication when Supabase is not configured.

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "Connection refused" | Check Supabase URL and keys in config |
| "Column does not exist" | Verify all SQL tables are created |
| "Email already exists" | Email is registered, use login instead |
| "Invalid credentials" | Check email/password are correct |
| App crashes on startup | Ensure Supabase.initialize() is called in main() |

## Next Steps

1. ✅ Email authentication implemented
2. ✅ User management implemented
3. ✅ Workout database CRUD operations
4. 🔲 Email verification (upcoming)
5. 🔲 Password reset flow (upcoming)
6. 🔲 Social authentication (upcoming)
7. 🔲 Real-time workouts sync (upcoming)
8. 🔲 Offline support (upcoming)

## Files Added/Modified

### New Files
- `lib/config/supabase_config.dart` - Supabase configuration
- `lib/services/supabase_auth_service.dart` - Supabase authentication
- `lib/services/supabase_workout_service.dart` - Supabase workouts
- `lib/providers/supabase_workout_provider.dart` - Workout state management
- `lib/screens/workouts/add_workout_screen.dart` - Add/edit workout UI
- `SUPABASE_SETUP.md` - Setup guide

### Modified Files
- `pubspec.yaml` - Added Supabase and crypto dependencies
- `lib/models/user_model.dart` - Changed id to int, added JSON serialization
- `lib/models/workout_model.dart` - Updated schema to match database
- `lib/services/auth_service.dart` - Added Supabase integration
- `lib/providers/auth_provider.dart` - Enhanced with error handling
- `lib/screens/auth/auth_screen.dart` - Added error message display

## Dependencies

```yaml
supabase_flutter: ^2.0.0  # Flutter Supabase client
supabase: ^2.0.0          # Core Supabase client
crypto: ^3.0.0            # Password hashing
provider: ^6.0.1          # State management (existing)
flutter:                  # Flutter SDK (existing)
```
