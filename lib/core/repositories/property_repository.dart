import 'package:bh_finder/core/models/property_model.dart';

import 'package:bh_finder/core/view_models/tenant_property_card_data.dart';
import 'package:bh_finder/core/view_models/landlord_property_card_data.dart';
import 'package:bh_finder/core/view_models/property_detail_data.dart';

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
