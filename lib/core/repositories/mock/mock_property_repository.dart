import 'package:bh_finder/core/data/mock/properties/mock_properties.dart';
import 'package:bh_finder/core/data/mock/landlords/mock_landlords.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/models/property_model.dart';

import 'package:bh_finder/core/repositories/property_repository.dart';

import 'package:bh_finder/core/repositories/mock/mock_room_repository.dart';

import 'package:bh_finder/core/view_models/tenant_property_card_data.dart';
import 'package:bh_finder/core/view_models/landlord_property_card_data.dart';
import 'package:bh_finder/core/view_models/property_detail_data.dart';

//============================================================================
//! MOCK PROPERTY REPOSITORY
//============================================================================

class MockPropertyRepository implements PropertyRepository {
  //============================================================================
  //! DEPENDENCIES
  //============================================================================

  final MockRoomRepository _roomRepository = MockRoomRepository();

  //============================================================================
  //! GETTERS
  //============================================================================

  @override
  Future<List<PropertyModel>> getAll() async {
    return mockProperties;
  }

  @override
  Future<PropertyModel?> getById(String propertyId) async {
    try {
      return mockProperties.firstWhere((property) => property.id == propertyId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<PropertyModel>> getByLandlord(String landlordId) async {
    return mockProperties
        .where((property) => property.landlordId == landlordId)
        .toList();
  }

  //============================================================================
  //! PROPERTY CARDS
  //============================================================================

  @override
  Future<List<TenantPropertyCardData>> getPropertyCards() async {
    final cards = <TenantPropertyCardData>[];

    for (final property in mockProperties) {
      final minimumPrice = await _roomRepository.getMinimumPrice(property.id);

      final roomCount = await _roomRepository.getRoomCount(property.id);

      cards.add(
        TenantPropertyCardData(
          id: property.id,

          title: property.title,

          coverImageUrl: property.imageUrls.first,

          minimumPrice: minimumPrice,

          roomCount: roomCount,

          status: property.status,

          genderPreference: property.genderPreference,

          favoriteCount: property.favoriteCount,

          distance: 0,

          amenities: property.amenities,

          isFavorite: false,
        ),
      );
    }

    return cards;
  }

  @override
  Future<List<LandlordPropertyCardData>> getLandlordPropertyCards() async {
    final cards = <LandlordPropertyCardData>[];

    for (final property in mockProperties) {
      final roomCount = await _roomRepository.getRoomCount(property.id);

      final landlord = mockLandlords.firstWhere(
        (landlord) => landlord.id == property.landlordId,
      );

      cards.add(
        LandlordPropertyCardData(
          id: property.id,

          title: property.title,

          coverImageUrl: property.imageUrls.first,

          status: property.status,

          distance: 0,

          totalRooms: roomCount,

          totalViews: 0,

          totalFavorites: property.favoriteCount,

          totalInquiries: 0,

          isVerified:
              landlord.verificationStatus == VerificationStatus.verified,
        ),
      );
    }

    return cards;
  }

  //============================================================================
  //! PROPERTY DETAIL
  //============================================================================

  @override
  Future<PropertyDetailData> getPropertyDetail(String propertyId) async {
    final property = await getById(propertyId);

    if (property == null) {
      throw Exception('Property not found.');
    }

    final landlord = mockLandlords.firstWhere(
      (landlord) => landlord.id == property.landlordId,
    );

    return PropertyDetailData(
      id: property.id,

      title: property.title,

      description: property.description,

      imageUrls: property.imageUrls,

      minimumPrice: await _roomRepository.getMinimumPrice(property.id),

      roomCount: await _roomRepository.getRoomCount(property.id),

      rooms: await _roomRepository.getByProperty(property.id),

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
