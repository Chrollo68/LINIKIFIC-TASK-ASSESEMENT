import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  /// Initialize Supabase
  /// Replace with your own Supabase URL and Anon Key from your Supabase project
  static const String supabaseUrl = 'https://jtqxtmyljshyfqkzljzt.supabase.co';
  static const String supabaseAnonKey =
      'sb_publishable_dMzBrbx-f_VZ-QpuW9m1cw_ghHWGh2V';

  static Future<void> initialize() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  static Supabase get instance => Supabase.instance;
  static SupabaseClient get client => Supabase.instance.client;
}

/// SQL Commands to run in Supabase SQL Editor to create tables:
///
/// -- Create users table
/// CREATE TABLE users (
///   id BIGSERIAL PRIMARY KEY,
///   name TEXT NOT NULL,
///   email TEXT UNIQUE NOT NULL,
///   password TEXT NOT NULL,
///   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
///   updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
/// );
///
/// -- Create workouts table
/// CREATE TABLE workouts (
///   id BIGSERIAL PRIMARY KEY,
///   user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
///   title TEXT NOT NULL,
///   duration INTEGER NOT NULL,
///   calories INTEGER NOT NULL,
///   date DATE NOT NULL,
///   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
/// );
