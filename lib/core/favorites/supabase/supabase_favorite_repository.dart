import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bh_finder/core/favorites/respositories/favorite_repository.dart';

//============================================================================
//! SUPABASE FAVORITE REPOSITORY
//============================================================================

class SupabaseFavoriteRepository implements FavoriteRepository {
  //============================================================================
  //! DEPENDENCIES
  //============================================================================

  final SupabaseClient _supabase = Supabase.instance.client;

  //============================================================================
  //! IS FAVORITE
  //============================================================================

  @override
  Future<bool> isFavorite({required String propertyId}) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      return false;
    }

    final favorite = await _supabase
        .from('favorites')
        .select('property_id')
        .eq('user_id', userId)
        .eq('property_id', propertyId)
        .maybeSingle();

    return favorite != null;
  }

  //============================================================================
  //! ADD FAVORITE
  //============================================================================

  @override
  Future<void> addFavorite({required String propertyId}) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      throw Exception('User is not authenticated.');
    }

    await _supabase.from('favorites').insert({
      'user_id': userId,
      'property_id': propertyId,
    });
  }

  //============================================================================
  //! REMOVE FAVORITE
  //============================================================================

  @override
  Future<void> removeFavorite({required String propertyId}) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      throw Exception('User is not authenticated.');
    }

    await _supabase
        .from('favorites')
        .delete()
        .eq('user_id', userId)
        .eq('property_id', propertyId);
  }

  //============================================================================
  //! TOGGLE FAVORITE
  //============================================================================

  @override
  Future<void> toggleFavorite({required String propertyId}) async {
    final favorite = await isFavorite(propertyId: propertyId);

    if (favorite) {
      await removeFavorite(propertyId: propertyId);
    } else {
      await addFavorite(propertyId: propertyId);
    }
  }

  //============================================================================
  //! FAVORITE PROPERTY IDS
  //============================================================================

  @override
  Future<List<String>> getFavoritePropertyIds() async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      return [];
    }

    final rows = await _supabase
        .from('favorites')
        .select('property_id')
        .eq('user_id', userId);

    return rows.map<String>((row) => row['property_id'] as String).toList();
  }
}
