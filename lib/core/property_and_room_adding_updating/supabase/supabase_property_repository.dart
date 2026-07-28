import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/models/property_model.dart';
import 'package:bh_finder/core/models/image_model.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/storage_repository.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/landlord_property_card_data.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/property_detail_data.dart';

//============================================================================
//! SUPABASE PROPERTY REPOSITORY
//============================================================================

class SupabasePropertyRepository implements PropertyRepository {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  SupabasePropertyRepository({
    required StorageRepository storageRepository,
    required RoomRepository roomRepository,
  }) : _storageRepository = storageRepository,
       _roomRepository = roomRepository;

  //============================================================================
  //! DEPENDENCIES
  //============================================================================

  final SupabaseClient _supabase = Supabase.instance.client;

  final StorageRepository _storageRepository;

  final RoomRepository _roomRepository;

  //============================================================================
  //! GET ALL
  //============================================================================

  @override
  Future<List<PropertyModel>> getAll() async {
    final response = await _supabase
        .from('properties')
        .select()
        .order('created_at');

    return response.map<PropertyModel>(_mapProperty).toList();
  }

  //============================================================================
  //! GET BY ID
  //============================================================================

  @override
  Future<PropertyModel?> getById(String propertyId) async {
    final response = await _supabase
        .from('properties')
        .select()
        .eq('id', propertyId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return _mapProperty(response);
  }

  //============================================================================
  //! GET BY LANDLORD
  //============================================================================

  @override
  Future<List<PropertyModel>> getByLandlord(String landlordId) async {
    final response = await _supabase
        .from('properties')
        .select()
        .eq('owner_id', landlordId)
        .order('created_at');

    return response.map<PropertyModel>(_mapProperty).toList();
  }

  //============================================================================
  //! CREATE
  //============================================================================

  @override
  Future<String> create(PropertyModel property) async {
    //----------------------------------------------------------
    // Current User
    //----------------------------------------------------------

    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      throw Exception('User is not authenticated.');
    }
    //----------------------------------------------------------
    // Insert Property
    //----------------------------------------------------------

    final inserted = await _supabase
        .from('properties')
        .insert({
          'owner_id': userId,
          'title': property.title,
          'description': property.description,
          'address': property.address,
          'latitude': property.latitude,
          'longitude': property.longitude,
          'availability_status': property.status.name,
          'amenities': property.amenities.map((e) => e.name).toList(),
          'views': property.views,
        })
        .select()
        .single();

    final propertyId = inserted['id'] as String;

    //----------------------------------------------------------
    // Upload Images
    //----------------------------------------------------------

    final localPaths = property.images
        .where((image) => image.isLocal)
        .map((image) => image.path)
        .toList();

    final uploadedPaths = await _storageRepository.uploadPropertyImages(
      propertyId: propertyId,
      localPaths: localPaths,
    );

    //----------------------------------------------------------
    // Save Property Images
    //----------------------------------------------------------

    if (uploadedPaths.isNotEmpty) {
      final rows = <Map<String, dynamic>>[];

      for (int i = 0; i < uploadedPaths.length; i++) {
        rows.add({
          'property_id': propertyId,
          'storage_path': uploadedPaths[i],
          'display_order': i,
        });
      }

      await _supabase.from('property_images').insert(rows);
    }

    return propertyId;
  }

  //============================================================================
  //! MAP PROPERTY
  //============================================================================

  PropertyModel _mapProperty(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      landlordId: json['owner_id'],
      title: json['title'],
      description: json['description'],
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),

      // Images are loaded separately from property_images.
      images: const [],

      amenities: (json['amenities'] as List)
          .map(
            (e) => Amenity.values.firstWhere(
              (a) => a.toString().split('.').last == e,
            ),
          )
          .toList(),

      // Computed later from rooms.
      genderPreference: GenderPreference.mixed,

      views: json['views'] ?? 0,

      status: PropertyStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['availability_status'],
      ),
    );
  }

  //============================================================================
  //! UPDATE
  //============================================================================

  @override
  Future<void> update(PropertyModel property) async {
    //----------------------------------------------------------
    // Update Property
    //----------------------------------------------------------

    await _supabase
        .from('properties')
        .update({
          'title': property.title,
          'description': property.description,
          'address': property.address,
          'latitude': property.latitude,
          'longitude': property.longitude,
          'availability_status': property.status.name,
          'amenities': property.amenities.map((e) => e.name).toList(),
        })
        .eq('id', property.id);

    //----------------------------------------------------------
    // Existing Images In Database
    //----------------------------------------------------------

    final existingRows = await _supabase
        .from('property_images')
        .select('storage_path')
        .eq('property_id', property.id);

    final existingStoragePaths = existingRows
        .map<String>((row) => row['storage_path'] as String)
        .toSet();

    //----------------------------------------------------------
    // Images User Kept
    //----------------------------------------------------------

    final keptStoragePaths = property.images
        .where((image) => !image.isLocal)
        .map((image) => image.storagePath!)
        .toSet();

    //----------------------------------------------------------
    // Delete Removed Images
    //----------------------------------------------------------

    final removedStoragePaths = existingStoragePaths.difference(
      keptStoragePaths,
    );

    if (removedStoragePaths.isNotEmpty) {
      await _storageRepository.deleteFiles(removedStoragePaths.toList());
    }

    //----------------------------------------------------------
    // Remove Existing Database Rows
    //----------------------------------------------------------

    await _supabase
        .from('property_images')
        .delete()
        .eq('property_id', property.id);

    //----------------------------------------------------------
    // Upload New Images
    //----------------------------------------------------------

    final localPaths = property.images
        .where((image) => image.isLocal)
        .map((image) => image.path)
        .toList();

    final uploadedStoragePaths = await _storageRepository.uploadPropertyImages(
      propertyId: property.id,
      localPaths: localPaths,
    );

    //----------------------------------------------------------
    // Rebuild Image Rows
    //----------------------------------------------------------

    final rows = <Map<String, dynamic>>[];

    int uploadedIndex = 0;

    for (int i = 0; i < property.images.length; i++) {
      final image = property.images[i];

      rows.add({
        'property_id': property.id,
        'storage_path': image.isLocal
            ? uploadedStoragePaths[uploadedIndex++]
            : image.storagePath!,
        'display_order': i,
      });
    }

    if (rows.isNotEmpty) {
      await _supabase.from('property_images').insert(rows);
    }
  }

  //============================================================================
  //! DELETE
  //============================================================================

  @override
  Future<void> delete(String propertyId) async {
    //----------------------------------------------------------
    // Existing Images
    //----------------------------------------------------------

    final existingImages = await _supabase
        .from('property_images')
        .select('storage_path')
        .eq('property_id', propertyId);

    final storagePaths = existingImages
        .map<String>((image) => image['storage_path'] as String)
        .toList();

    //----------------------------------------------------------
    // Delete Storage Files
    //----------------------------------------------------------

    if (storagePaths.isNotEmpty) {
      await _storageRepository.deleteFiles(storagePaths);
    }

    //----------------------------------------------------------
    // Delete Property
    //----------------------------------------------------------

    await _supabase.from('properties').delete().eq('id', propertyId);
  }

  //============================================================================
  //! TENANT PROPERTY CARDS
  //============================================================================
  @override
  Future<List<TenantPropertyCardData>> getPropertyCards() async {
    //----------------------------------------------------------
    // Properties
    //----------------------------------------------------------

    final properties = await getAll();

    final cards = <TenantPropertyCardData>[];

    for (final property in properties) {
      //--------------------------------------------------------
      // Cover Image
      //--------------------------------------------------------

      final image = await _supabase
          .from('property_images')
          .select('storage_path')
          .eq('property_id', property.id)
          .order('display_order', ascending: true)
          .limit(1)
          .maybeSingle();

      String coverImageUrl = '';

      if (image != null) {
        coverImageUrl = _storageRepository.getPublicUrl(
          'properties',
          (image['storage_path'] as String).replaceFirst('properties/', ''),
        );
      }

      //--------------------------------------------------------
      // Computed Values
      //--------------------------------------------------------

      final rooms = await _roomRepository.getByProperty(property.id);

      final minimumPrice = await _roomRepository.getMinimumPrice(property.id);

      final roomCount = await _roomRepository.getRoomCount(property.id);

      GenderPreference genderPreference = GenderPreference.mixed;

      if (rooms.isNotEmpty) {
        final genders = rooms.map((room) => room.genderPreference).toSet();

        if (genders.length == 1) {
          genderPreference = genders.first;
        }
      }

      //--------------------------------------------------------
      // Card
      //--------------------------------------------------------

      cards.add(
        TenantPropertyCardData(
          id: property.id,
          title: property.title,
          coverImageUrl: coverImageUrl,
          minimumPrice: minimumPrice,
          roomCount: roomCount,
          status: property.status,
          genderPreference: genderPreference,
          favoriteCount: 0,
          address: property.address,
          amenities: property.amenities,
          isFavorite: false,
        ),
      );
    }

    return cards;
  }

  //============================================================================
  //! LANDLORD PROPERTY CARDS
  //============================================================================
  @override
  Future<List<LandlordPropertyCardData>> getLandlordPropertyCards() async {
    //----------------------------------------------------------
    // Current User
    //----------------------------------------------------------

    final userId = _supabase.auth.currentUser!.id;

    //----------------------------------------------------------
    // Properties
    //----------------------------------------------------------

    final properties = await getByLandlord(userId);

    final cards = <LandlordPropertyCardData>[];

    for (final property in properties) {
      //--------------------------------------------------------
      // Cover Image
      //--------------------------------------------------------

      final image = await _supabase
          .from('property_images')
          .select('storage_path')
          .eq('property_id', property.id)
          .order('display_order', ascending: true)
          .limit(1)
          .maybeSingle();

      String coverImageUrl = '';

      if (image != null) {
        coverImageUrl = _storageRepository.getPublicUrl(
          'properties',
          (image['storage_path'] as String).replaceFirst('properties/', ''),
        );
      }

      //--------------------------------------------------------
      // Computed Values
      //--------------------------------------------------------

      final totalRooms = await _roomRepository.getRoomCount(property.id);

      //--------------------------------------------------------
      // Card
      //--------------------------------------------------------

      cards.add(
        LandlordPropertyCardData(
          id: property.id,
          title: property.title,
          coverImageUrl: coverImageUrl,
          address: property.address,
          totalRooms: totalRooms,
          totalViews: property.views,
          totalFavorites: 0,
          totalInquiries: 0,
          status: property.status,
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
    //----------------------------------------------------------
    // Property
    //----------------------------------------------------------

    final property = await getById(propertyId);

    if (property == null) {
      throw Exception('Property not found.');
    }

    //----------------------------------------------------------
    // Images
    //----------------------------------------------------------

    final imageRows = await _supabase
        .from('property_images')
        .select()
        .eq('property_id', propertyId)
        .order('display_order', ascending: true);

    final images = imageRows.map((image) {
      final storagePath = image['storage_path'] as String;

      return ImageModel(
        path: _storageRepository.getPublicUrl(
          'properties',
          storagePath.replaceFirst('properties/', ''),
        ),
        storagePath: storagePath,
        isLocal: false,
      );
    }).toList();

    //----------------------------------------------------------
    // Rooms
    //----------------------------------------------------------

    final rooms = await _roomRepository.getByProperty(propertyId);

    final minimumPrice = await _roomRepository.getMinimumPrice(propertyId);

    final roomCount = await _roomRepository.getRoomCount(propertyId);

    //----------------------------------------------------------
    // Gender Preference
    //----------------------------------------------------------

    GenderPreference genderPreference = GenderPreference.mixed;

    if (rooms.isNotEmpty) {
      final genders = rooms.map((room) => room.genderPreference).toSet();

      if (genders.length == 1) {
        genderPreference = genders.first;
      }
    }

    //----------------------------------------------------------
    // TODO
    //----------------------------------------------------------
    //
    // Landlord will come from ProfileRepository later.
    //

    return PropertyDetailData(
      id: property.id,
      title: property.title,
      description: property.description,
      images: images,
      minimumPrice: minimumPrice,
      roomCount: roomCount,
      genderPreference: genderPreference,
      totalViews: property.views,
      totalInquiries: 0,
      favoriteCount: 0,
      amenities: property.amenities,
      latitude: property.latitude,
      longitude: property.longitude,
      landlord: null,
      status: property.status,
      rooms: rooms,
      address: property.address,
    );
  }
}
