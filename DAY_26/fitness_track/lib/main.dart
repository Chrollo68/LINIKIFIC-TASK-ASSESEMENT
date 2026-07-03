import 'package:flutter/material.dart';
import 'package:fitness_track/config/supabase_config.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await SupabaseConfig.initialize();

  runApp(const FitnessApp());
}
