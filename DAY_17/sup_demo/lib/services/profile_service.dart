import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_profile.dart';

class ProfileService {
  final SupabaseClient _client = Supabase.instance.client;
  static final ProfileService instance = ProfileService._();
  ProfileService._();

  Future<UserProfile?> fetchProfile(String userId) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .limit(1)
        .execute();

    final data = response.data;
    if (data is List && data.isNotEmpty) {
      return UserProfile.fromMap(Map<String, dynamic>.from(data.first));
    }
    return null;
  }

  Future<UserProfile> createProfile(UserProfile profile) async {
    final response = await _client
        .from('profiles')
        .insert(profile.toMap())
        .select()
        .execute();

    final inserted = response.data;
    if (inserted is List && inserted.isNotEmpty) {
      return UserProfile.fromMap(Map<String, dynamic>.from(inserted.first));
    }
    throw Exception('Failed to create profile');
  }

  Future<UserProfile> fetchOrCreateProfile(UserProfile profile) async {
    final existing = await fetchProfile(profile.id);
    if (existing != null) {
      return existing;
    }
    return await createProfile(profile);
  }

  Future<void> updateProfile(String userId, String fullName) async {
    await _client
        .from('profiles')
        .update({
          'full_name': fullName,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', userId)
        .execute();
  }
}
