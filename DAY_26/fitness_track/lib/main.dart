import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fitness_track/config/supabase_config.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    print('Loading .env file...');
    await dotenv.load(fileName: '.env');
    print('✓ .env file loaded');
    print('SUPABASE_URL: ${dotenv.env['SUPABASE_URL']}');
    print(
      'SUPABASE_ANON_KEY: ${dotenv.env['SUPABASE_ANON_KEY']?.substring(0, 20)}...',
    );

    print('Initializing Supabase...');
    await SupabaseConfig.initialize();
    print('✓ Supabase initialized successfully');
  } catch (e, stackTrace) {
    print('❌ Initialization Error: $e');
    print('Stack Trace: $stackTrace');
    rethrow;
  }

  runApp(const FitnessApp());
}
