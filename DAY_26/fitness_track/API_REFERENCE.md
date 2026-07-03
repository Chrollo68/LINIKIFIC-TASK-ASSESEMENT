# FitFlow API Reference - Supabase Integration

## Table of Contents
1. [Authentication Service](#authentication-service)
2. [Workout Service](#workout-service)
3. [Data Models](#data-models)
4. [Error Handling](#error-handling)

---

## Authentication Service

### AuthService (lib/services/auth_service.dart)

**Purpose**: Handles user authentication with Supabase fallback support

#### Methods

##### `Future<UserModel?> login(String email, String password)`
**Description**: Authenticate user with email and password

**Parameters**:
- `email` (String): User email address
- `password` (String): User password

**Returns**: `UserModel?` - User object if successful, null if failed

**Example**:
```dart
final authService = AuthService();
final user = await authService.login('user@example.com', 'password123');
if (user != null) {
  print('Logged in as: ${user.name}');
}
```

##### `Future<UserModel?> register(String name, String email, String password)`
**Description**: Create a new user account

**Parameters**:
- `name` (String): User's full name
- `email` (String): User's email address
- `password` (String): User's password (min 6 chars)

**Returns**: `UserModel?` - New user object if successful, null if failed

**Example**:
```dart
final user = await authService.register(
  'John Doe',
  'john@example.com',
  'password123'
);
```

##### `Future<void> logout()`
**Description**: Logout the current user

**Returns**: `Future<void>`

**Example**:
```dart
await authService.logout();
```

##### `UserModel? getCurrentUser()`
**Description**: Get the currently logged-in user

**Returns**: `UserModel?` - Current user or null

**Example**:
```dart
final currentUser = authService.getCurrentUser();
```

##### `Future<UserModel?> updateUser(UserModel user)`
**Description**: Update user profile information

**Parameters**:
- `user` (UserModel): Updated user object

**Returns**: `UserModel?` - Updated user object

**Example**:
```dart
final updated = await authService.updateUser(
  currentUser.copyWith(name: 'Jane Doe')
);
```

##### `Future<bool> emailExists(String email)`
**Description**: Check if email is already registered

**Parameters**:
- `email` (String): Email to check

**Returns**: `bool` - true if email exists, false otherwise

**Example**:
```dart
final exists = await authService.emailExists('user@example.com');
```

---

## Workout Service

### SupabaseWorkoutService (lib/services/supabase_workout_service.dart)

**Purpose**: Manages workout data in Supabase

#### Methods

##### `Future<WorkoutModel?> addWorkout({required int userId, required String title, required int duration, required int calories, required DateTime date})`
**Description**: Add a new workout

**Parameters**:
- `userId` (int): User who owns the workout
- `title` (String): Workout name (e.g., "Morning Run")
- `duration` (int): Duration in minutes
- `calories` (int): Calories burned
- `date` (DateTime): When the workout occurred

**Returns**: `WorkoutModel?` - Created workout object

**Example**:
```dart
final service = SupabaseWorkoutService();
final workout = await service.addWorkout(
  userId: 123,
  title: 'Morning Jog',
  duration: 30,
  calories: 250,
  date: DateTime.now(),
);
```

##### `Future<List<WorkoutModel>> getUserWorkouts(int userId)`
**Description**: Get all workouts for a user

**Parameters**:
- `userId` (int): User ID

**Returns**: `List<WorkoutModel>` - List of workouts ordered by date (newest first)

**Example**:
```dart
final workouts = await service.getUserWorkouts(123);
print('Total workouts: ${workouts.length}');
```

##### `Future<List<WorkoutModel>> getWorkoutsByDate(int userId, DateTime date)`
**Description**: Get workouts for a specific date

**Parameters**:
- `userId` (int): User ID
- `date` (DateTime): Target date

**Returns**: `List<WorkoutModel>` - Workouts for that date

**Example**:
```dart
final todayWorkouts = await service.getWorkoutsByDate(
  123,
  DateTime.now(),
);
```

##### `Future<WorkoutModel?> updateWorkout({required int workoutId, required String title, required int duration, required int calories, required DateTime date})`
**Description**: Update an existing workout

**Parameters**:
- `workoutId` (int): Workout ID to update
- `title` (String): New title
- `duration` (int): New duration
- `calories` (int): New calories
- `date` (DateTime): New date

**Returns**: `WorkoutModel?` - Updated workout

**Example**:
```dart
final updated = await service.updateWorkout(
  workoutId: 456,
  title: 'Evening Run',
  duration: 45,
  calories: 350,
  date: DateTime.now(),
);
```

##### `Future<bool> deleteWorkout(int workoutId)`
**Description**: Delete a workout

**Parameters**:
- `workoutId` (int): Workout ID to delete

**Returns**: `bool` - true if successful

**Example**:
```dart
final success = await service.deleteWorkout(456);
```

##### `Future<int> getTotalCaloriesByDate(int userId, DateTime date)`
**Description**: Calculate total calories burned on a date

**Parameters**:
- `userId` (int): User ID
- `date` (DateTime): Target date

**Returns**: `int` - Total calories for that date

**Example**:
```dart
final totalCal = await service.getTotalCaloriesByDate(123, DateTime.now());
print('Calories burned today: $totalCal');
```

##### `Future<int> getTotalWorkoutsCount(int userId)`
**Description**: Get total workout count for user

**Parameters**:
- `userId` (int): User ID

**Returns**: `int` - Total workouts completed

**Example**:
```dart
final count = await service.getTotalWorkoutsCount(123);
```

##### `Future<double> getAverageDuration(int userId)`
**Description**: Calculate average workout duration

**Parameters**:
- `userId` (int): User ID

**Returns**: `double` - Average duration in minutes

**Example**:
```dart
final avg = await service.getAverageDuration(123);
print('Average workout: ${avg.toStringAsFixed(1)} minutes');
```

---

## Provider Services

### AuthProvider (lib/providers/auth_provider.dart)

**Purpose**: State management for authentication

#### Properties

```dart
UserModel? get user               // Current logged-in user
bool get isLoading               // Loading state
bool get isAuthenticated         // Authentication status
String? get errorMessage         // Last error message
```

#### Methods

```dart
Future<bool> login(String email, String password)
Future<bool> register(String name, String email, String password)
Future<void> logout()
Future<bool> updateProfile(UserModel updatedUser)
void clearError()
UserModel? getCurrentUser()
```

### SupabaseWorkoutProvider (lib/providers/supabase_workout_provider.dart)

**Purpose**: State management for workouts

#### Properties

```dart
List<WorkoutModel> get workouts          // All user workouts
List<WorkoutModel> get todayWorkouts     // Today's workouts
ProgressModel get progress               // Progress statistics
bool get isLoading                       // Loading state
String? get errorMessage                 // Last error message
```

#### Methods

```dart
Future<void> loadWorkouts(int userId)
Future<void> loadTodayWorkouts(int userId)
Future<WorkoutModel?> addWorkout({...})
Future<WorkoutModel?> updateWorkout({...})
Future<bool> deleteWorkout(int workoutId, int userId)
void completeWorkout(WorkoutModel workout)
void updateWater(int amount)
void clearError()
```

---

## Data Models

### UserModel (lib/models/user_model.dart)

```dart
class UserModel {
  final int id;           // Unique identifier from database
  final String name;      // User's full name
  final String email;     // User's email (unique)
  final String password;  // Hashed password
  final String? photoPath;
  final double height;    // Height in cm
  final double weight;    // Weight in kg
}

// Methods
double get bmi                    // Calculate BMI
Map<String, dynamic> toJson()     // Convert to JSON for API
factory UserModel.fromJson()      // Create from JSON
UserModel copyWith({...})         // Create modified copy
```

### WorkoutModel (lib/models/workout_model.dart)

```dart
class WorkoutModel {
  final int id;              // Unique identifier
  final int userId;          // Owner of the workout
  final String title;        // Workout name
  final int duration;        // Minutes
  final int calories;        // Calories burned
  final DateTime date;       // When it was done
  final String difficulty;   // Optional: Easy/Medium/Hard
  final String icon;         // Optional: Emoji icon
  final String description;  // Optional: Details
}

// Methods
Map<String, dynamic> toJson()      // Convert to JSON
factory WorkoutModel.fromJson()    // Create from JSON
WorkoutModel copyWith({...})       // Create modified copy
```

### ProgressModel (lib/models/progress_model.dart)

```dart
class ProgressModel {
  final int calories;         // Calories burned today
  final int water;            // Water intake in ml
  final int workoutsCompleted; // Total workouts
  final double bmi;           // Body mass index
}
```

---

## Error Handling

### Common Error Messages

| Error | Cause | Solution |
|-------|-------|----------|
| "Invalid email or password" | Wrong credentials | Check email and password |
| "Email already registered" | Email exists | Use different email or login |
| "Enter a valid email address" | Bad email format | Use format: user@domain.com |
| "Password must be at least 6 characters" | Password too short | Use 6+ characters |
| "Enter your name" | Name is empty | Provide user's name |
| "Failed to load workouts" | Network error | Check internet connection |
| "Failed to add workout" | Database error | Try again or contact support |

### Error Handling Pattern

```dart
try {
  final success = await authProvider.login(email, password);
  if (success) {
    // User authenticated
  } else {
    // Check errorMessage for specific error
    print(authProvider.errorMessage);
  }
} catch (e) {
  print('Exception: $e');
}
```

---

## Usage Patterns

### Pattern 1: Complete Registration Flow
```dart
final authProvider = context.read<AuthProvider>();

// Register
final success = await authProvider.register(
  'John Doe',
  'john@example.com',
  'password123',
);

if (success) {
  // User is now authenticated
  final userId = authProvider.user!.id;
  
  // Load workouts
  final workoutProvider = context.read<SupabaseWorkoutProvider>();
  await workoutProvider.loadWorkouts(userId);
} else {
  // Show error
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(authProvider.errorMessage!))
  );
}
```

### Pattern 2: Adding and Viewing Workouts
```dart
final userId = authProvider.user!.id;

// Add workout
await workoutProvider.addWorkout(
  userId: userId,
  title: 'Morning Run',
  duration: 30,
  calories: 250,
  date: DateTime.now(),
);

// Load today's workouts
await workoutProvider.loadTodayWorkouts(userId);

// Display workouts
for (var workout in workoutProvider.todayWorkouts) {
  print('${workout.title}: ${workout.duration} min');
}

// Check progress
print('Total calories: ${workoutProvider.progress.calories}');
```

### Pattern 3: Editing Workouts
```dart
// Update existing workout
await workoutProvider.updateWorkout(
  workoutId: workoutToEdit.id,
  title: 'Evening Run',
  duration: 45,
  calories: 350,
  date: DateTime.now(),
);

// Or delete
await workoutProvider.deleteWorkout(
  workoutToEdit.id,
  userId,
);
```

---

## Configuration

### Initialize Supabase in main.dart

```dart
import 'package:fitness_track/config/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await SupabaseConfig.initialize();
  
  runApp(const MyApp());
}
```

### Environment Setup

Update `lib/config/supabase_config.dart`:

```dart
static const String supabaseUrl = 'YOUR_PROJECT_URL';
static const String supabaseAnonKey = 'YOUR_ANON_KEY';
```

Get these values from Supabase Dashboard → Settings → API.

---

## Testing

### Test Credentials (Local Fallback)
```
Email: admin@gmail.com
Password: 123456
```

### Creating Test Data

```dart
// Create test user
final user = await authProvider.register(
  'Test User',
  'test@example.com',
  'test123456',
);

// Add test workouts
await workoutProvider.addWorkout(
  userId: user.id,
  title: 'Test Workout',
  duration: 30,
  calories: 200,
  date: DateTime.now(),
);
```

---

## Performance Tips

1. **Load data once**: Cache workouts in Provider state
2. **Use date filtering**: `getWorkoutsByDate()` for better performance
3. **Batch operations**: Update UI after all database calls
4. **Avoid unnecessary reloads**: Check if data exists before fetching
5. **Use indexes**: Database indexes on user_id and date for speed
