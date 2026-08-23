import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/models/image_model.dart';
import 'package:bh_finder/core/models/landlord_model.dart';
import 'package:bh_finder/core/models/property_model.dart';

import 'package:bh_finder/core/repositories/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories/room_repository.dart';
import 'package:bh_finder/core/repositories/repositories/storage_repository.dart';

import 'package:bh_finder/core/ui_models/landlord_property_card_data.dart';
import 'package:bh_finder/core/ui_models/property_detail_data.dart';
import 'package:bh_finder/core/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/core/models/search_filter_model.dart';

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
  //! FIELDS
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

      images: const [],

      amenities: (json['amenities'] as List)
          .map((e) => Amenity.values.firstWhere((a) => a.name == e))
          .toList(),

      minimumPrice: (json['minimum_price'] as num).toDouble(),

      genderPreference: GenderPreference.values.firstWhere(
        (e) => e.name == json['gender_preference'],
      ),

      views: json['views'] ?? 0,

      status: PropertyStatus.values.firstWhere(
        (e) => e.name == json['availability_status'],
      ),

      createdAt: DateTime.parse(json['created_at'] as String),

      updatedAt: DateTime.parse(json['updated_at'] as String),
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
    // Delete Property
    //----------------------------------------------------------

    await _supabase.from('properties').delete().eq('id', propertyId);

    //----------------------------------------------------------
    // Delete Storage Files
    //----------------------------------------------------------

    if (storagePaths.isNotEmpty) {
      _deleteStorageFilesInBackground(storagePaths);
    }
  }

  //============================================================================
  //! BACKGROUND STORAGE CLEANUP
  //============================================================================

  void _deleteStorageFilesInBackground(List<String> storagePaths) {
    _storageRepository.deleteFiles(storagePaths).catchError((_) {});
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

    //----------------------------------------------------------
    // Current User Favorites
    //----------------------------------------------------------

    final userId = _supabase.auth.currentUser?.id;

    final favoriteIds = <String>{};

    if (userId != null) {
      final rows = await _supabase
          .from('favorites')
          .select('property_id')
          .eq('user_id', userId);

      favoriteIds.addAll(rows.map((row) => row['property_id'] as String));
    }

    //----------------------------------------------------------
    // Favorite Counts
    //----------------------------------------------------------

    final favoriteRows = await _supabase
        .from('favorites')
        .select('property_id');

    final favoriteCounts = <String, int>{};

    for (final row in favoriteRows) {
      final propertyId = row['property_id'] as String;

      favoriteCounts[propertyId] = (favoriteCounts[propertyId] ?? 0) + 1;
    }

    return _buildTenantPropertyCards(
      properties: properties,
      favoriteIds: favoriteIds,
      favoriteCounts: favoriteCounts,
    );
  }

  //============================================================================
  //! BUILD TENANT PROPERTY CARDS
  //============================================================================

  Future<List<TenantPropertyCardData>> _buildTenantPropertyCards({
    required List<PropertyModel> properties,
    required Set<String> favoriteIds,
    required Map<String, int> favoriteCounts,
  }) async {
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
      // Room Count
      //--------------------------------------------------------

      final roomCount = await _roomRepository.getRoomCount(property.id);

      //--------------------------------------------------------
      // Card
      //--------------------------------------------------------

      cards.add(
        TenantPropertyCardData(
          id: property.id,
          title: property.title,
          coverImageUrl: coverImageUrl,
          minimumPrice: property.minimumPrice,
          roomCount: roomCount,
          status: property.status,
          genderPreference: property.genderPreference,
          address: property.address,
          amenities: property.amenities,
          isFavorite: favoriteIds.contains(property.id),
          favoriteCount: favoriteCounts[property.id] ?? 0,
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

      final favoriteRows = await _supabase
          .from('favorites')
          .select('property_id')
          .eq('property_id', property.id);

      final totalFavorites = favoriteRows.length;

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
          totalFavorites: totalFavorites,
          totalInquiries: 0,
          status: property.status,
        ),
      );
    }

    return cards;
  }

  //============================================================================
  //! FAVORITE PROPERTY CARDS
  //============================================================================

  @override
  Future<List<TenantPropertyCardData>> getFavoritePropertyCards() async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      return [];
    }

    final favoriteRows = await _supabase
        .from('favorites')
        .select('property_id')
        .eq('user_id', userId);

    final favoriteIds = favoriteRows
        .map<String>((row) => row['property_id'] as String)
        .toSet();

    final allProperties = await getPropertyCards();

    return allProperties
        .where((property) => favoriteIds.contains(property.id))
        .toList();
  }

  //============================================================================
  //! SEARCH FAVORITE PROPERTY CARDS
  //============================================================================

  @override
  Future<List<TenantPropertyCardData>> searchFavoritePropertyCards(
    SearchFilterModel filter,
  ) async {
    //----------------------------------------------------------
    // Search All Matching Properties
    //----------------------------------------------------------

    final properties = await searchProperties(filter);

    //----------------------------------------------------------
    // Keep Favorites Only
    //----------------------------------------------------------

    return properties.where((property) => property.isFavorite).toList();
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

    final roomCount = await _roomRepository.getRoomCount(propertyId);

    //----------------------------------------------------------
    // Landlord
    //----------------------------------------------------------

    final profile = await _supabase
        .from('profiles')
        .select()
        .eq('id', property.landlordId)
        .maybeSingle();

    LandlordModel? landlord;

    if (profile != null) {
      final avatarPath = profile['avatar_path'] as String?;

      landlord = LandlordModel(
        id: profile['id'] as String,
        fullName: '${profile['first_name']} ${profile['last_name']}'.trim(),
        phoneNumber: profile['phone'] ?? '',
        profileImageUrl: avatarPath == null || avatarPath.isEmpty
            ? ''
            : _storageRepository.getPublicUrl(
                'avatars',
                avatarPath.replaceFirst('avatars/', ''),
              ),
        verificationStatus: switch (profile['verification_status']) {
          'not_submitted' => VerificationStatus.notSubmitted,
          'pending' => VerificationStatus.pending,
          'approved' => VerificationStatus.approved,
          'rejected' => VerificationStatus.rejected,
          _ => VerificationStatus.pending,
        },
        lastSeenAt: profile['last_seen_at'] == null
            ? null
            : DateTime.parse(profile['last_seen_at'] as String),
      );
    }

    //----------------------------------------------------------
    // Favorite Count
    //----------------------------------------------------------

    final favoriteRows = await _supabase
        .from('favorites')
        .select('property_id')
        .eq('property_id', propertyId);

    final favoriteCount = favoriteRows.length;

    return PropertyDetailData(
      id: property.id,
      title: property.title,
      description: property.description,
      images: images,
      minimumPrice: property.minimumPrice,
      roomCount: roomCount,
      genderPreference: property.genderPreference,
      totalViews: property.views,
      totalInquiries: 0,
      favoriteCount: favoriteCount,
      amenities: property.amenities,
      latitude: property.latitude,
      longitude: property.longitude,
      landlord: landlord,
      status: property.status,
      rooms: rooms,
      address: property.address,
      createdAt: property.createdAt,
      updatedAt: property.updatedAt,
    );
  }

  //============================================================================
  //! SEARCH PROPERTIES
  //============================================================================

  @override
  Future<List<TenantPropertyCardData>> searchProperties(
    SearchFilterModel filter,
  ) async {
    //----------------------------------------------------------
    // Query
    //----------------------------------------------------------

    var query = _supabase.from('properties').select();

    //----------------------------------------------------------
    // Search Text
    //----------------------------------------------------------

    if (filter.query.trim().isNotEmpty) {
      final text = filter.query.trim();

      query = query.or('title.ilike.%$text%,address.ilike.%$text%');
    }

    //----------------------------------------------------------
    // Budget
    //----------------------------------------------------------

    switch (filter.budget) {
      case '₱1,500 - ₱3,000':
        query = query.gte('minimum_price', 1500).lte('minimum_price', 3000);
        break;

      case '₱3,000 - ₱5,000':
        query = query.gte('minimum_price', 3000).lte('minimum_price', 5000);
        break;

      case '₱5,000+':
        query = query.gte('minimum_price', 5000);
        break;
    }

    //----------------------------------------------------------
    // Gender
    //----------------------------------------------------------

    switch (filter.gender) {
      case 'Male':
        query = query.eq('gender_preference', 'male');
        break;

      case 'Female':
        query = query.eq('gender_preference', 'female');
        break;

      case 'Mixed':
        query = query.eq('gender_preference', 'mixed');
        break;
    }

    //----------------------------------------------------------
    // Status
    //----------------------------------------------------------

    switch (filter.status) {
      case 'Available':
        query = query.eq('availability_status', 'available');
        break;

      case 'Occupied':
        query = query.eq('availability_status', 'occupied');
        break;
    }

    //----------------------------------------------------------
    // Amenities
    //----------------------------------------------------------

    if (filter.amenities.isNotEmpty) {
      query = query.filter(
        'amenities',
        'cs',
        '{${filter.amenities.join(',')}}',
      );
    }

    //----------------------------------------------------------
    // Load Properties
    //----------------------------------------------------------

    final rows = await query.order('created_at');

    final properties = rows.map<PropertyModel>(_mapProperty).toList();

    //----------------------------------------------------------
    // Current User Favorites
    //----------------------------------------------------------

    final userId = _supabase.auth.currentUser?.id;

    final favoriteIds = <String>{};

    if (userId != null) {
      final rows = await _supabase
          .from('favorites')
          .select('property_id')
          .eq('user_id', userId);

      favoriteIds.addAll(rows.map((row) => row['property_id'] as String));
    }

    //----------------------------------------------------------
    // Favorite Counts
    //----------------------------------------------------------

    final favoriteRows = await _supabase
        .from('favorites')
        .select('property_id');

    final favoriteCounts = <String, int>{};

    for (final row in favoriteRows) {
      final propertyId = row['property_id'] as String;

      favoriteCounts[propertyId] = (favoriteCounts[propertyId] ?? 0) + 1;
    }

    //----------------------------------------------------------
    // Build Cards
    //----------------------------------------------------------

    return _buildTenantPropertyCards(
      properties: properties,
      favoriteIds: favoriteIds,
      favoriteCounts: favoriteCounts,
    );
  }

  //============================================================================
  //! RECORD VIEW
  //============================================================================

  @override
  Future<void> recordView({required String propertyId}) async {
    //----------------------------------------------------------
    // Current User
    //----------------------------------------------------------

    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      return;
    }

    //----------------------------------------------------------
    // Already Viewed?
    //----------------------------------------------------------

    final existing = await _supabase
        .from('property_views')
        .select()
        .eq('user_id', userId)
        .eq('property_id', propertyId)
        .maybeSingle();

    if (existing != null) {
      return;
    }

    //----------------------------------------------------------
    // Save View Record
    //----------------------------------------------------------

    await _supabase.from('property_views').insert({
      'user_id': userId,
      'property_id': propertyId,
    });

    //----------------------------------------------------------
    // Increment Property Views
    //----------------------------------------------------------

    await _supabase.rpc(
      'increment_property_views',
      params: {'property_uuid': propertyId},
    );
  }
}
