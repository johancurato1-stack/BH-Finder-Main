import 'package:bh_finder/core/data/mock/landlords/mock_landlords.dart';
import 'package:bh_finder/core/models/landlord_model.dart';

//============================================================================
//! LANDLORD REPOSITORY
//============================================================================

class LandlordRepository {
  const LandlordRepository();

  //============================================================================
  //! GET LANDLORD BY ID
  //============================================================================

  /// Returns a landlord by its ID.
  /// Returns null if the landlord doesn't exist.
  LandlordModel? getById(String landlordId) {
    try {
      return mockLandlords.firstWhere((landlord) => landlord.id == landlordId);
    } catch (_) {
      return null;
    }
  }

  //============================================================================
  //! GET ALL LANDLORDS
  //============================================================================

  /// Returns all landlords.
  List<LandlordModel> getAll() {
    return mockLandlords;
  }
}
