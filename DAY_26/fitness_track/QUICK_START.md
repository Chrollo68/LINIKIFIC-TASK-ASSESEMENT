# FitFlow - Supabase Integration - Quick Start Guide

## 🎯 What's New

Your fitness_track project now has full Supabase integration with:

✅ **Email/Password Authentication**
- User registration with validation
- User login with error handling  
- Password hashing (SHA256)
- User session management

✅ **Database Integration**
- Users table with structured schema
- Workouts table with proper relationships
- Full CRUD operations for workouts
- Date-based workout filtering

✅ **State Management**
- Enhanced AuthProvider with error tracking
- New SupabaseWorkoutProvider for workout management
- Loading state tracking
- Error message display

✅ **UI Enhancements**
- Updated auth screen with error display
- New add/edit workout screen
- Form validation
- User-friendly error messages

---

## 🚀 Quick Start (5 Steps)

### Step 1: Create Supabase Project
1. Go to https://supabase.com
2. Sign up and create a new project
3. Note your **Project URL** and **Anon Key**

### Step 2: Create Database Tables
In Supabase SQL Editor, run these commands:

```sql
-- Users Table
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_users_email ON users(email);

-- Workouts Table
CREATE TABLE workouts (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  duration INTEGER NOT NULL,
  calories INTEGER NOT NULL,
  date DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_workouts_user_id ON workouts(user_id);
CREATE INDEX idx_workouts_date ON workouts(date);
```

### Step 3: Configure Your App
Edit `lib/config/supabase_config.dart`:

```dart
static const String supabaseUrl = 'https://your-project.supabase.co';
static const String supabaseAnonKey = 'your-anon-key';
```

### Step 4: Install Dependencies
Already added to `pubspec.yaml`. Just run:

```bash
flutter pub get
```

### Step 5: Initialize Supabase
Make sure `main.dart` has:

```dart
import 'package:fitness_track/config/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();
  runApp(const MyApp());
}
```

**Done! 🎉 Your app is ready to use Supabase!**

---

## 📁 File Structure

### New Files Created
```
lib/
├── config/
│   └── supabase_config.dart              ✨ NEW
├── services/
│   ├── supabase_auth_service.dart        ✨ NEW
│   └── supabase_workout_service.dart     ✨ NEW
├── providers/
│   └── supabase_workout_provider.dart    ✨ NEW
└── screens/
    └── workouts/
        └── add_workout_screen.dart       ✨ NEW

Documentation/
├── SUPABASE_SETUP.md                     ✨ NEW - Detailed setup guide
├── IMPLEMENTATION_GUIDE.md               ✨ NEW - Implementation details
└── API_REFERENCE.md                      ✨ NEW - API documentation
```

### Modified Files
```
pubspec.yaml                    ⚡ Added Supabase + crypto
lib/models/user_model.dart      ⚡ Changed id to int, added JSON
lib/models/workout_model.dart   ⚡ Updated schema, added JSON
lib/services/auth_service.dart  ⚡ Added Supabase support
lib/providers/auth_provider.dart ⚡ Enhanced with error handling
lib/screens/auth/auth_screen.dart ⚡ Added error display
```

---

## 🔐 Database Schema

### Users Table
| Field | Type | Notes |
|-------|------|-------|
| id | Integer | Primary key, auto-increment |
| name | String | User's full name |
| email | String | Unique email address |
| password | String | SHA256 hashed password |
| created_at | Timestamp | Account creation time |
| updated_at | Timestamp | Last update time |

### Workouts Table
| Field | Type | Notes |
|-------|------|-------|
| id | Integer | Primary key, auto-increment |
| user_id | Integer | Foreign key to users.id |
| title | String | Workout name |
| duration | Integer | Duration in minutes |
| calories | Integer | Calories burned |
| date | Date | When workout occurred |
| created_at | Timestamp | Record creation time |

---

## 💡 Usage Examples

### Register New User
```dart
final authProvider = context.read<AuthProvider>();

final success = await authProvider.register(
  'John Doe',
  'john@example.com',
  'password123'
);

if (success) {
  print('Registration successful!');
  // Navigate to home
} else {
  print('Error: ${authProvider.errorMessage}');
}
```

### Login User
```dart
final success = await authProvider.login(
  'john@example.com',
  'password123'
);

if (success) {
  print('Logged in as: ${authProvider.user!.name}');
}
```

### Add Workout
```dart
final workoutProvider = context.read<SupabaseWorkoutProvider>();

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
await workoutProvider.loadWorkouts(authProvider.user!.id);

for (var workout in workoutProvider.workouts) {
  print('${workout.title}: ${workout.calories} cal');
}
```

### Check Progress
```dart
print('Calories today: ${workoutProvider.progress.calories}');
print('Workouts completed: ${workoutProvider.progress.workoutsCompleted}');
```

---

## 🧪 Testing

### Demo Credentials (Local Fallback)
These work without Supabase configured:
```
Email: admin@gmail.com
Password: 123456
```

### Create Test User
```dart
// Register
await authProvider.register(
  'Test User',
  'test@example.com',
  'test123456'
);

// Add test workout
await workoutProvider.addWorkout(
  userId: authProvider.user!.id,
  title: 'Test Workout',
  duration: 30,
  calories: 200,
  date: DateTime.now(),
);

// View progress
print('Progress: ${workoutProvider.progress}');
```

---

## 📚 Documentation

Three comprehensive guides are included:

1. **SUPABASE_SETUP.md** - Step-by-step setup instructions
2. **IMPLEMENTATION_GUIDE.md** - Architecture and implementation details
3. **API_REFERENCE.md** - Complete API documentation with examples

---

## ✨ Key Features

### Authentication
- ✅ Email validation
- ✅ Password strength checking (min 6 chars)
- ✅ Email uniqueness validation
- ✅ Password hashing
- ✅ Error messages
- ✅ Session management

### Workouts
- ✅ Create workouts with title, duration, calories, date
- ✅ View all workouts for a user
- ✅ Filter workouts by date
- ✅ Update workouts
- ✅ Delete workouts
- ✅ Calculate progress statistics

### State Management
- ✅ Provider-based state management
- ✅ Loading state tracking
- ✅ Error handling with messages
- ✅ User session state
- ✅ Workout list state
- ✅ Progress tracking

---

## 🔄 Fallback Mode

If Supabase isn't configured, the app falls back to local authentication:
- Useful for development/testing
- Same API interface
- Automatic transition to Supabase when configured
- Demo user: admin@gmail.com / 123456

---

## 🛠️ Troubleshooting

### "Connection refused"
✓ Check Supabase URL and keys in config
✓ Verify Supabase project is active

### "Column does not exist"  
✓ Run all SQL commands to create tables
✓ Check SQL syntax in Supabase

### "Email already exists"
✓ Email is already registered
✓ Use login instead or different email

### "Invalid credentials"
✓ Check email and password
✓ Try demo credentials: admin@gmail.com / 123456

---

## 📋 Dependencies Added

```yaml
supabase_flutter: ^2.0.0  # Supabase client
supabase: ^2.0.0          # Core library
crypto: ^3.0.0            # Password hashing
```

---

## 🎓 Next Steps

1. ✅ Read SUPABASE_SETUP.md for detailed configuration
2. ✅ Review IMPLEMENTATION_GUIDE.md for architecture
3. ✅ Check API_REFERENCE.md for available methods
4. ✅ Test with demo credentials
5. ✅ Configure your Supabase project
6. ✅ Create test users and workouts
7. ✅ Build additional features!

---

## 📞 Support Resources

- **Supabase Docs**: https://supabase.com/docs
- **Flutter Supabase**: https://pub.dev/packages/supabase_flutter
- **Provider Package**: https://pub.dev/packages/provider
- **API Reference**: See API_REFERENCE.md in project

---

## 🚀 You're All Set!

Your fitness app now has:
- ✅ Secure user authentication
- ✅ Cloud database storage
- ✅ Workout tracking
- ✅ Progress monitoring
- ✅ Error handling

**Happy coding! 🎉**
