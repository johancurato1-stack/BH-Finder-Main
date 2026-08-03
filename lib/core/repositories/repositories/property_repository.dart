import 'package:bh_finder/core/models/property_model.dart';

import 'package:bh_finder/core/ui_models/landlord_property_card_data.dart';
import 'package:bh_finder/core/ui_models/property_detail_data.dart';
import 'package:bh_finder/core/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/core/models/search_filter_model.dart';

//============================================================================
//! PROPERTY REPOSITORY
//============================================================================

abstract class PropertyRepository {
  //============================================================================
  //! GETTERS
  //============================================================================

  /// Returns all properties.
  Future<List<PropertyModel>> getAll();

  /// Returns a property by its ID.
  Future<PropertyModel?> getById(String propertyId);

  /// Returns all properties owned by a landlord.
  Future<List<PropertyModel>> getByLandlord(String landlordId);

  //============================================================================
  //! COMMANDS
  //============================================================================

  /// Creates a new property.
  Future<String> create(PropertyModel property);

  /// Updates an existing property.
  Future<void> update(PropertyModel property);

  /// Deletes a property.
  Future<void> delete(String propertyId);

  //============================================================================
  //! PROPERTY CARDS
  //============================================================================

  /// Returns property cards for tenants.
  Future<List<TenantPropertyCardData>> getPropertyCards();

  /// Returns property cards for landlords.
  Future<List<LandlordPropertyCardData>> getLandlordPropertyCards();

  /// Returns the current user's favorite property cards.
  Future<List<TenantPropertyCardData>> getFavoritePropertyCards();

  /// Searches the current user's favorite property cards.
  Future<List<TenantPropertyCardData>> searchFavoritePropertyCards(
    SearchFilterModel filter,
  );

  //============================================================================
  //! SEARCH
  //============================================================================

  /// Returns property cards matching the search filter.
  Future<List<TenantPropertyCardData>> searchProperties(
    SearchFilterModel filter,
  );

  //============================================================================
  //! PROPERTY DETAIL
  //============================================================================

  /// Returns the data used by the property detail screen.
  Future<PropertyDetailData> getPropertyDetail(String propertyId);

  //============================================================================
  //! PROPERTY VIEWS
  //============================================================================

  /// Records a property view.
  Future<void> recordView({required String propertyId});
}
