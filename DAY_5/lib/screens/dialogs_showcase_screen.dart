import 'package:flutter/material.dart';

class DialogsShowcaseScreen extends StatelessWidget {
  const DialogsShowcaseScreen({super.key});

  Future<void> _showConfirmationDialog(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Action'),
          content: const Text('Do you want to continue with this action?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Proceed'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      messenger.showSnackBar(const SnackBar(content: Text('Action confirmed')));
    }
  }

  Future<void> _showOptionDialog(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final selected = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Choose a theme'),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 'Light'),
              child: const Text('Light Theme'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 'Dark'),
              child: const Text('Dark Theme'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 'System'),
              child: const Text('System Theme'),
            ),
          ],
        );
      },
    );

    if (selected != null) {
      messenger.showSnackBar(SnackBar(content: Text('Selected: $selected')));
    }
  }

  Future<void> _showCustomDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, size: 64, color: Colors.deepPurple),
                const SizedBox(height: 16),
                Text(
                  'Custom Dialog',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                const Text(
                  'This dialog uses a custom shape and styling to highlight advanced UI capabilities.',
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showBottomSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 6,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.onSurface.withAlpha(0x33),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Bottom Sheet Content',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              const Text(
                'This modal bottom sheet shows additional actions without changing the page.',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Dismiss'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (selectedDate != null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Selected date: ${selectedDate.toLocal().toString().split(' ')[0]}',
          ),
        ),
      );
    }
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      final formattedTime =
          '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
      messenger.showSnackBar(
        SnackBar(
          content: Text('Selected time: $formattedTime'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dialogs Showcase')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => _showConfirmationDialog(context),
              child: const Text('Show AlertDialog'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => _showOptionDialog(context),
              child: const Text('Show SimpleDialog'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => _showCustomDialog(context),
              child: const Text('Show Custom Dialog'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => _showBottomSheet(context),
              icon: const Icon(Icons.expand_less),
              label: const Text('Show Bottom Sheet'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => _showDatePicker(context),
              icon: const Icon(Icons.calendar_today),
              label: const Text('Show Date Picker'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => _showTimePicker(context),
              icon: const Icon(Icons.access_time),
              label: const Text('Show Time Picker'),
            ),
            const SizedBox(height: 24),
            Text(
              'Dialogs are used for short interactions that require user confirmation or selection. Bottom sheets and pickers extend the interaction model with helpful overlays.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
