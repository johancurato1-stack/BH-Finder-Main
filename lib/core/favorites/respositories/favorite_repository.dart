abstract class FavoriteRepository {
  //============================================================================
  //! FAVORITES
  //============================================================================

  /// Returns true if the current user has favorited the property.
  Future<bool> isFavorite({required String propertyId});

  /// Adds the property to the current user's favorites.
  Future<void> addFavorite({required String propertyId});

  /// Removes the property from the current user's favorites.
  Future<void> removeFavorite({required String propertyId});

  /// Toggles the favorite state.
  Future<void> toggleFavorite({required String propertyId});

  /// Returns the IDs of all properties favorited by the current user.
  Future<List<String>> getFavoritePropertyIds();
}
