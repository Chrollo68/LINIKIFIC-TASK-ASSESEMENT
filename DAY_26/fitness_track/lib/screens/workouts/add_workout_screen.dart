import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/workout_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/supabase_workout_provider.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_text_field.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key, this.workoutToEdit});

  final WorkoutModel? workoutToEdit;

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  late TextEditingController _titleController;
  late TextEditingController _durationController;
  late TextEditingController _caloriesController;
  late DateTime _selectedDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.workoutToEdit?.title ?? '',
    );
    _durationController = TextEditingController(
      text: widget.workoutToEdit?.duration.toString() ?? '',
    );
    _caloriesController = TextEditingController(
      text: widget.workoutToEdit?.calories.toString() ?? '',
    );
    _selectedDate = widget.workoutToEdit?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final workoutProvider = context.read<SupabaseWorkoutProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.workoutToEdit != null ? 'Edit Workout' : 'Add Workout',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Workout Details',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'Workout Title',
                  hint: 'e.g., Morning Run',
                  controller: _titleController,
                  icon: Icons.fitness_center,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Enter workout title' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Duration (minutes)',
                  hint: 'e.g., 30',
                  controller: _durationController,
                  icon: Icons.schedule,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter duration';
                    }
                    if (int.tryParse(value!) == null) {
                      return 'Enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Calories Burned',
                  hint: 'e.g., 250',
                  controller: _caloriesController,
                  icon: Icons.local_fire_department,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter calories';
                    }
                    if (int.tryParse(value!) == null) {
                      return 'Enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Date',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Text(
                    '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                const SizedBox(height: 32),
                Consumer<SupabaseWorkoutProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PrimaryButton(
                          label: widget.workoutToEdit != null
                              ? 'Update Workout'
                              : 'Add Workout',
                          icon: Icons.save,
                          isLoading: provider.isLoading,
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) return;

                            if (authProvider.user == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please login first'),
                                ),
                              );
                              return;
                            }

                            final success = widget.workoutToEdit != null
                                ? await workoutProvider.updateWorkout(
                                    workoutId: widget.workoutToEdit!.id,
                                    title: _titleController.text,
                                    duration: int.parse(
                                      _durationController.text,
                                    ),
                                    calories: int.parse(
                                      _caloriesController.text,
                                    ),
                                    date: _selectedDate,
                                  )
                                : await workoutProvider.addWorkout(
                                    userId: authProvider.user!.id,
                                    title: _titleController.text,
                                    duration: int.parse(
                                      _durationController.text,
                                    ),
                                    calories: int.parse(
                                      _caloriesController.text,
                                    ),
                                    date: _selectedDate,
                                  );

                            if (!mounted) return;

                            if (success != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    widget.workoutToEdit != null
                                        ? 'Workout updated successfully'
                                        : 'Workout added successfully',
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    provider.errorMessage ??
                                        'Failed to save workout',
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        if (widget.workoutToEdit != null) ...[
                          const SizedBox(height: 12),
                          OutlinedButton(
                            onPressed: () async {
                              final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Delete Workout?'),
                                  content: const Text(
                                    'This action cannot be undone.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirmed ?? false) {
                                final success = await workoutProvider
                                    .deleteWorkout(
                                      widget.workoutToEdit!.id,
                                      authProvider.user!.id,
                                    );

                                if (!mounted) return;

                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Workout deleted'),
                                    ),
                                  );
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        provider.errorMessage ??
                                            'Failed to delete workout',
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text('Delete Workout'),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
