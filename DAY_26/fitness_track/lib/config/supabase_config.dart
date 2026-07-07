import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static late Supabase _supabase;
  static bool _isInitialized = false;

  static String get supabaseUrl {
    final url = dotenv.env['SUPABASE_URL'];
    if (url == null || url.isEmpty) {
      throw Exception('SUPABASE_URL environment variable is not set');
    }
    return url;
  }

  static String get supabaseAnonKey {
    final key = dotenv.env['SUPABASE_ANON_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('SUPABASE_ANON_KEY environment variable is not set');
    }
    return key;
  }

  static Future<void> initialize() async {
    if (_isInitialized) {
      print('Supabase is already initialized');
      return;
    }

    try {
      print('Starting Supabase initialization...');
      print('URL: $supabaseUrl');

      _supabase = await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );

      _isInitialized = true;
      print('✓ Supabase initialized successfully');
    } catch (e) {
      print('✗ Supabase initialization failed: $e');
      rethrow;
    }
  }

  static Supabase get instance {
    if (!_isInitialized) {
      throw Exception(
        'Supabase has not been initialized. Call initialize() first.',
      );
    }
    return _supabase;
  }

  static SupabaseClient get client {
    if (!_isInitialized) {
      throw Exception(
        'Supabase has not been initialized. Call initialize() first.',
      );
    }
    return Supabase.instance.client;
  }
}
