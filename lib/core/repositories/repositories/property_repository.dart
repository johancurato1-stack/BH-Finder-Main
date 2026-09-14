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

  Future<List<PropertyModel>> getAll();

  Future<PropertyModel?> getById(String propertyId);

  Future<List<PropertyModel>> getByLandlord(String landlordId);

  //============================================================================
  //! COMMANDS
  //============================================================================

  Future<String> create(PropertyModel property);

  Future<void> update(PropertyModel property);

  Future<void> delete(String propertyId);

  //============================================================================
  //! PROPERTY CARDS
  //============================================================================

  Future<List<TenantPropertyCardData>> getPropertyCards();

  Future<List<TenantPropertyCardData>> getNewPropertyCards(
    Set<String> existingPropertyIds,
  );

  Future<List<LandlordPropertyCardData>> getLandlordPropertyCards();

  Future<List<TenantPropertyCardData>> getFavoritePropertyCards();

  Future<List<TenantPropertyCardData>> searchFavoritePropertyCards(
    SearchFilterModel filter,
  );

  //============================================================================
  //! SEARCH
  //============================================================================

  Future<List<TenantPropertyCardData>> searchProperties(
    SearchFilterModel filter,
  );

  //============================================================================
  //! PROPERTY DETAIL
  //============================================================================

  Future<PropertyDetailData> getPropertyDetail(String propertyId);

  //============================================================================
  //! PROPERTY VIEWS
  //============================================================================

  Future<void> recordView({required String propertyId});
}
