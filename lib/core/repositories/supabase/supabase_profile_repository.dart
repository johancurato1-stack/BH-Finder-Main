import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bh_finder/core/repositories/repositories/profile_repository.dart';

//============================================================================
//! SUPABASE PROFILE REPOSITORY
//============================================================================

class SupabaseProfileRepository implements ProfileRepository {
  //============================================================================
  //! FIELDS
  //============================================================================

  final SupabaseClient _supabase = Supabase.instance.client;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  SupabaseProfileRepository();

  //============================================================================
  //! GETTERS
  //============================================================================

  @override
  Future<Map<String, dynamic>?> getCurrentProfile() async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      return null;
    }

    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    return response;
  }

  @override
  Future<int> getFavoritesCount() async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      return 0;
    }

    final response = await _supabase
        .from('favorites')
        .select()
        .eq('user_id', user.id);

    return response.length;
  }

  @override
  Future<int> getInquiriesCount() async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      return 0;
    }

    final response = await _supabase
        .from('chats')
        .select()
        .eq('tenant_id', user.id);

    return response.length;
  }

  @override
  Future<int> getPropertiesCount() async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      return 0;
    }

    final response = await _supabase
        .from('properties')
        .select()
        .eq('owner_id', user.id);

    return response.length;
  }

  //============================================================================
  //! COMMANDS
  //============================================================================

  @override
  Future<void> updateAvatarPath(String avatarPath) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      return;
    }

    await _supabase
        .from('profiles')
        .update({'avatar_path': avatarPath})
        .eq('id', user.id);
  }

  @override
  Future<void> updateLastActiveRole(String role) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      return;
    }

    await _supabase
        .from('profiles')
        .update({'last_active_role': role})
        .eq('id', user.id);
  }
  //============================================================================
  //! UPDATE LAST SEEN
  //============================================================================

  @override
  Future<void> updateLastSeen() async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      return;
    }

    await _supabase
        .from('profiles')
        .update({'last_seen_at': DateTime.now().toUtc().toIso8601String()})
        .eq('id', user.id);
  }
}
