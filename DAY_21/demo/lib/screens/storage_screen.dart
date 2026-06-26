import 'package:flutter/material.dart';
import '../services/hive_service.dart';
import '../utils/helpers.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  final HiveService _hiveService = HiveService();
  String _storedValue = 'No value yet';

  Future<void> _saveData() async {
    await _hiveService.save('Hello from Hive!');
    final value = await _hiveService.getMessage();

    setState(() {
      _storedValue = value;
    });
  }

  Future<void> _loadData() async {
    final value = await _hiveService.getMessage();
    setState(() {
      _storedValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hive Demo')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Stored message:', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 12),
              Text(
                _storedValue,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveData,
                child: const Text('Save Data to Hive'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: Helpers.shareApp,
                child: const Text('Share App'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: Helpers.openFlutterSite,
                child: const Text('Open flutter.dev'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
