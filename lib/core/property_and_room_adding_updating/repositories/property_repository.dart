import 'package:bh_finder/core/property_and_room_adding_updating/models/property_model.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/landlord_property_card_data.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/property_detail_data.dart';

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
  //! CRUD
  //============================================================================

  Future<String> create(PropertyModel property);

  Future<void> update(PropertyModel property);

  Future<void> delete(String propertyId);

  //============================================================================
  //! PROPERTY CARDS
  //============================================================================

  Future<List<TenantPropertyCardData>> getPropertyCards();

  Future<List<LandlordPropertyCardData>> getLandlordPropertyCards();

  //============================================================================
  //! PROPERTY DETAIL
  //============================================================================

  Future<PropertyDetailData> getPropertyDetail(String propertyId);
}
