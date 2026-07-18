import 'package:bh_finder/core/data/mock/properties/mock_properties.dart';
import 'package:bh_finder/core/models/property_model.dart';
import 'package:bh_finder/core/repositories/landlord_repository.dart';
import 'package:bh_finder/core/repositories/room_repository.dart';
import 'package:bh_finder/core/view_models/landlord_property_card_data.dart';
import 'package:bh_finder/core/view_models/property_card_data.dart';
import 'package:bh_finder/core/view_models/property_detail_data.dart';

//============================================================================
//! PROPERTY REPOSITORY
//============================================================================

class PropertyRepository {
  //============================================================================
  //! DEPENDENCIES
  //============================================================================

  final RoomRepository _roomRepository = RoomRepository();

  final LandlordRepository _landlordRepository = LandlordRepository();

  //============================================================================
  //! GETTERS
  //============================================================================

  /// Returns all properties.
  List<PropertyModel> getAll() {
    return mockProperties;
  }

  /// Returns a property by its ID.
  PropertyModel? getById(String propertyId) {
    try {
      return mockProperties.firstWhere((property) => property.id == propertyId);
    } catch (_) {
      return null;
    }
  }

  /// Returns all properties owned by a landlord.
  List<PropertyModel> getByLandlord(String landlordId) {
    return mockProperties
        .where((property) => property.landlordId == landlordId)
        .toList();
  }

  //============================================================================
  //! GET PROPERTY CARDS
  //============================================================================

  List<PropertyCardData> getPropertyCards() {
    return mockProperties.map((property) {
      return PropertyCardData(
        id: property.id,
        title: property.title,
        coverImageUrl: property.imageUrls.first,
        minimumPrice: _roomRepository.getMinimumPrice(property.id),
        roomCount: _roomRepository.getRoomCount(property.id),
        status: property.status,
        genderPreference: property.genderPreference,
        favoriteCount: property.favoriteCount,
        distance: 0,
        amenities: property.amenities,

        // Temporary until favorites are implemented
        isFavorite: false,
      );
    }).toList();
  }

  //============================================================================
  //! GET LANDLORD PROPERTY CARDS
  //============================================================================

  List<LandlordPropertyCardData> getLandlordPropertyCards() {
    return mockProperties.map((property) {
      return LandlordPropertyCardData(
        id: property.id,
        title: property.title,
        coverImageUrl: property.imageUrls.first,
        status: property.status,
        distance: 0,

        totalRooms: _roomRepository.getRoomCount(property.id),

        // TODO: Replace with real analytics later.
        totalViews: 0,
        totalFavorites: property.favoriteCount,
        totalInquiries: 0,

        // TODO: Replace when property verification is implemented.
        isVerified: false,
      );
    }).toList();
  }

  //============================================================================
  //! GET PROPERTY DETAIL
  //============================================================================

  PropertyDetailData getPropertyDetail(String propertyId) {
    final property = getById(propertyId);

    if (property == null) {
      throw Exception('Property not found.');
    }

    final landlord = _landlordRepository.getById(property.landlordId);

    if (landlord == null) {
      throw Exception('Landlord not found.');
    }

    return PropertyDetailData(
      id: property.id,
      title: property.title,
      description: property.description,
      imageUrls: property.imageUrls,
      minimumPrice: _roomRepository.getMinimumPrice(property.id),
      roomCount: _roomRepository.getRoomCount(property.id),
      rooms: _roomRepository.getByProperty(property.id),
      status: property.status,
      genderPreference: property.genderPreference,
      amenities: property.amenities,
      favoriteCount: property.favoriteCount,
      distance: 0,
      latitude: property.latitude,
      longitude: property.longitude,
      landlord: landlord,
    );
  }
}
