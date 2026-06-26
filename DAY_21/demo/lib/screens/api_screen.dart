import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String _title = 'Press the button to load data';

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final title = await _apiService.fetchPostTitle();
      setState(() {
        _title = title;
      });
    } catch (error) {
      setState(() {
        _title = 'Failed to fetch data';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Demo')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                const CircularProgressIndicator()
              else
                Text(
                  _title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loadData,
                child: const Text('Fetch Post Title'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
