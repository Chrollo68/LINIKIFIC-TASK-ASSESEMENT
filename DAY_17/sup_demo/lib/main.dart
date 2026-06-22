import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/supabase_config.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  runApp(const SupabaseApp());
}

class SupabaseApp extends StatefulWidget {
  const SupabaseApp({super.key});

  @override
  State<SupabaseApp> createState() => _SupabaseAppState();
}

class _SupabaseAppState extends State<SupabaseApp> {
  @override
  void initState() {
    super.initState();
    Supabase.instance.client.auth.onAuthStateChange.listen((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Supabase.instance.client.auth.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supabase Demo',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: currentUser == null ? const AuthScreen() : const HomeScreen(),
    );
  }
}
