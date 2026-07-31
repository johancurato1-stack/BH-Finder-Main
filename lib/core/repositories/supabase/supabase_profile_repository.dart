import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bh_finder/core/repositories/profile_repository.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/supabase/supabase_storage_repository.dart';

class SupabaseProfileRepository implements ProfileRepository {
  //============================================================================
  //! SUPABASE
  //============================================================================

  final SupabaseClient _supabase = Supabase.instance.client;

  //============================================================================
  //! PROFILE
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

  //============================================================================
  //! AVATAR
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

  //============================================================================
  //! TENANT
  //============================================================================

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

  //============================================================================
  //! LANDLORD
  //============================================================================

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
  //! ROLE
  //============================================================================

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
}
