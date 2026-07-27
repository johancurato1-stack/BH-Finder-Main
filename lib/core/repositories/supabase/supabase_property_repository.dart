import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/models/property_model.dart';

import 'package:bh_finder/core/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/supabase/supabase_room_repository.dart';

import 'package:bh_finder/core/view_models/tenant_property_card_data.dart';
import 'package:bh_finder/core/view_models/landlord_property_card_data.dart';
import 'package:bh_finder/core/view_models/property_detail_data.dart';

//============================================================================
//! SUPABASE PROPERTY REPOSITORY
//============================================================================

class SupabasePropertyRepository implements PropertyRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  final SupabaseRoomRepository _roomRepository = SupabaseRoomRepository();

  //============================================================================
  //! GET ALL PROPERTIES
  //============================================================================

  @override
  Future<List<PropertyModel>> getAll() async {
    final response = await _supabase.from('properties').select('''
          *,
          property_images (
            storage_path
          )
        ''');

    final properties = <PropertyModel>[];

    for (final property in response) {
      properties.add(await _mapProperty(property));
    }

    return properties;
  }

  //============================================================================
  //! GET PROPERTY BY ID
  //============================================================================

  @override
  Future<PropertyModel?> getById(String propertyId) async {
    final response = await _supabase
        .from('properties')
        .select('''
          *,
          property_images (
            storage_path
          )
        ''')
        .eq('id', propertyId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return await _mapProperty(response);
  }

  //============================================================================
  //! GET BY LANDLORD
  //============================================================================

  @override
  Future<List<PropertyModel>> getByLandlord(String landlordId) async {
    final response = await _supabase
        .from('properties')
        .select('''
          *,
          property_images (
            storage_path
          )
        ''')
        .eq('owner_id', landlordId);

    final properties = <PropertyModel>[];

    for (final property in response) {
      properties.add(await _mapProperty(property));
    }

    return properties;
  }

  //============================================================================
  //! CREATE PROPERTY
  //============================================================================

  @override
  Future<String> create(PropertyModel property) async {
    final response = await _supabase
        .from('properties')
        .insert({
          'owner_id': property.landlordId,
          'title': property.title,
          'description': property.description,
          'latitude': property.latitude,
          'longitude': property.longitude,
          'amenities': property.amenities.map((e) => e.name).toList(),
          'availability_status': property.status.name,
        })
        .select('id')
        .single();

    return response['id'] as String;
  }

  //============================================================================
  //! UPDATE PROPERTY
  //============================================================================

  @override
  Future<void> update(PropertyModel property) async {
    await _supabase
        .from('properties')
        .update({
          'title': property.title,
          'description': property.description,
          'latitude': property.latitude,
          'longitude': property.longitude,
          'amenities': property.amenities.map((e) => e.name).toList(),
          'availability_status': property.status.name,
        })
        .eq('id', property.id);
  }

  //============================================================================
  //! DELETE PROPERTY
  //============================================================================

  @override
  Future<void> delete(String propertyId) async {
    await _supabase.from('properties').delete().eq('id', propertyId);
  }

  //============================================================================
  //! PROPERTY CARDS
  //============================================================================

  @override
  Future<List<TenantPropertyCardData>> getPropertyCards() async {
    final properties = await getAll();

    return properties.map((property) {
      return TenantPropertyCardData(
        id: property.id,
        title: property.title,
        coverImageUrl: property.imageUrls.firstOrNull ?? '',
        minimumPrice: 0,
        roomCount: 0,
        status: property.status,
        genderPreference: property.genderPreference,
        favoriteCount: property.favoriteCount,
        distance: 0,
        amenities: property.amenities,
        isFavorite: false,
      );
    }).toList();
  }

  //============================================================================
  //! LANDLORD CARDS
  //============================================================================

  @override
  Future<List<LandlordPropertyCardData>> getLandlordPropertyCards() async {
    return [];
  }

  //============================================================================
  //! PROPERTY DETAIL
  //============================================================================

  @override
  Future<PropertyDetailData> getPropertyDetail(String propertyId) async {
    throw UnimplementedError();
  }

  //============================================================================
  //! MAPPER
  //============================================================================

  Future<PropertyModel> _mapProperty(Map<String, dynamic> property) async {
    final rooms = await _roomRepository.getByProperty(property['id']);

    return PropertyModel(
      id: property['id'],
      landlordId: property['owner_id'],
      title: property['title'],
      description: property['description'] ?? '',
      address: '',
      latitude: (property['latitude'] as num).toDouble(),
      longitude: (property['longitude'] as num).toDouble(),
      imageUrls: (property['property_images'] as List)
          .map((image) => image['storage_path'] as String)
          .toList(),
      amenities: (property['amenities'] as List)
          .map((item) => Amenity.values.firstWhere((e) => e.name == item))
          .toList(),
      genderPreference: _calculateGenderPreference(rooms),
      favoriteCount: 0,
      status: property['availability_status'] == 'available'
          ? PropertyStatus.available
          : PropertyStatus.occupied,
    );
  }

  GenderPreference _calculateGenderPreference(List rooms) {
    final genders = rooms.map((room) => room.genderPreference).toSet();

    if (genders.length == 1) {
      return genders.first;
    }

    return GenderPreference.mixed;
  }
}
