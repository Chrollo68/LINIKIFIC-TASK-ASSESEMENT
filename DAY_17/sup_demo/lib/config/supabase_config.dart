import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConfig {
  static String get url {
    final value = dotenv.env['SUPABASE_URL'] ?? '';
    if (value.isEmpty) {
      throw StateError('SUPABASE_URL is not set in .env');
    }
    return value;
  }

  static String get anonKey {
    final value = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
    if (value.isEmpty) {
      throw StateError('SUPABASE_ANON_KEY is not set in .env');
    }
    return value;
  }
}
