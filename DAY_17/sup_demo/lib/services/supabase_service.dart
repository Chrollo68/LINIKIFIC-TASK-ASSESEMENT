import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseClient get client => Supabase.instance.client;
  static final SupabaseService instance = SupabaseService._();
  SupabaseService._();

  User? get currentUser => client.auth.currentUser;

  Future<void> signUpWithEmail(String email, String password) async {
    await client.auth.signUp(email: email, password: password);
  }

  Future<void> signInWithEmail(String email, String password) async {
    await client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signInWithMagicLink(String email) async {
    await client.auth.signInWithOtp(email: email);
  }

  Future<void> signInWithGoogle() async {
    await client.auth.signInWithOAuth(Provider.google);
  }

  Future<void> signInWithGitHub() async {
    await client.auth.signInWithOAuth(Provider.github);
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }
}
