import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/models/room_model.dart';
import 'package:bh_finder/core/models/image_model.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/storage_repository.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/view_models/room_detail_data.dart';

//============================================================================
//! SUPABASE ROOM REPOSITORY
//============================================================================

class SupabaseRoomRepository implements RoomRepository {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  SupabaseRoomRepository({required StorageRepository storageRepository})
    : _storageRepository = storageRepository;

  //============================================================================
  //! DEPENDENCIES
  //============================================================================

  final SupabaseClient _supabase = Supabase.instance.client;

  final StorageRepository _storageRepository;

  //============================================================================
  //! GET ALL ROOMS
  //============================================================================

  @override
  Future<List<RoomModel>> getAll() async {
    final response = await _supabase.from('rooms').select();

    return response.map<RoomModel>(_mapRoom).toList();
  }

  //============================================================================
  //! GET ROOM BY ID
  //============================================================================

  @override
  Future<RoomModel?> getById(String roomId) async {
    final response = await _supabase
        .from('rooms')
        .select()
        .eq('id', roomId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return _mapRoom(response);
  }

  //============================================================================
  //! GET ROOMS BY PROPERTY
  //============================================================================

  @override
  Future<List<RoomModel>> getByProperty(String propertyId) async {
    //----------------------------------------------------------
    // Rooms
    //----------------------------------------------------------

    final roomRows = await _supabase
        .from('rooms')
        .select()
        .eq('property_id', propertyId);

    final rooms = <RoomModel>[];

    //----------------------------------------------------------
    // Load Images For Each Room
    //----------------------------------------------------------

    for (final row in roomRows) {
      final imageRows = await _supabase
          .from('room_images')
          .select()
          .eq('room_id', row['id'])
          .order('display_order', ascending: true);

      final imageUrls = imageRows
          .map<String>(
            (image) => _storageRepository.getPublicUrl(
              'rooms',
              (image['storage_path'] as String).replaceFirst('rooms/', ''),
            ),
          )
          .toList();

      rooms.add(
        RoomModel(
          id: row['id'],
          propertyId: row['property_id'],
          title: row['title'],
          description: row['description'] ?? '',
          price: (row['price'] as num).toDouble(),
          capacity: row['capacity'],
          genderPreference: GenderPreference.values.firstWhere(
            (e) => e.toString().split('.').last == row['gender_preference'],
          ),
          images: imageUrls
              .map((url) => ImageModel(path: url, isLocal: false))
              .toList(),
        ),
      );
    }

    return rooms;
  }

  //============================================================================
  //! MINIMUM PRICE
  //============================================================================

  @override
  Future<double> getMinimumPrice(String propertyId) async {
    final rooms = await getByProperty(propertyId);

    if (rooms.isEmpty) {
      return 0;
    }

    return rooms.map((room) => room.price).reduce((a, b) => a < b ? a : b);
  }

  //============================================================================
  //! ROOM COUNT
  //============================================================================

  @override
  Future<int> getRoomCount(String propertyId) async {
    final rooms = await getByProperty(propertyId);

    return rooms.length;
  }

  //============================================================================
  //! ROOM DETAIL
  //============================================================================

  @override
  Future<RoomDetailData> getRoomDetail(String roomId) async {
    //----------------------------------------------------------
    // Room
    //----------------------------------------------------------

    final room = await getById(roomId);

    if (room == null) {
      throw Exception('Room not found.');
    }

    //----------------------------------------------------------
    // Images
    //----------------------------------------------------------

    final imageRows = await _supabase
        .from('room_images')
        .select()
        .eq('room_id', roomId)
        .order('display_order', ascending: true);

    final images = imageRows.map((image) {
      final storagePath = image['storage_path'] as String;

      return ImageModel(
        path: _storageRepository.getPublicUrl(
          'rooms',
          storagePath.replaceFirst('rooms/', ''),
        ),
        storagePath: storagePath,
        isLocal: false,
      );
    }).toList();

    //----------------------------------------------------------
    // Room Detail
    //----------------------------------------------------------

    return RoomDetailData(
      id: room.id,
      propertyId: room.propertyId,
      title: room.title,
      description: room.description,
      price: room.price,
      capacity: room.capacity,
      genderPreference: room.genderPreference,
      images: images,
    );
  }

  //============================================================================
  //! MAP ROOM
  //============================================================================

  RoomModel _mapRoom(Map<String, dynamic> room) {
    return RoomModel(
      id: room['id'],
      propertyId: room['property_id'],
      title: room['title'],
      description: room['description'] ?? '',
      price: (room['price'] as num).toDouble(),
      capacity: room['capacity'],
      genderPreference: GenderPreference.values.firstWhere(
        (e) => e.toString().split('.').last == room['gender_preference'],
      ),

      // Images are loaded separately from room_images.
      images: const [],
    );
  }

  //============================================================================
  //! CREATE ROOM
  //============================================================================
  @override
  Future<void> create(RoomModel room) async {
    //----------------------------------------------------------
    // Insert Room
    //----------------------------------------------------------

    final inserted = await _supabase
        .from('rooms')
        .insert({
          'property_id': room.propertyId,
          'title': room.title,
          'description': room.description,
          'price': room.price,
          'capacity': room.capacity,
          'gender_preference': room.genderPreference.toString().split('.').last,
        })
        .select()
        .single();

    final roomId = inserted['id'] as String;

    //----------------------------------------------------------
    // Upload Images
    //----------------------------------------------------------

    final localPaths = room.images
        .where((image) => image.isLocal)
        .map((image) => image.path)
        .toList();

    final uploadedPaths = await _storageRepository.uploadRoomImages(
      roomId: roomId,
      localPaths: localPaths,
    );

    //----------------------------------------------------------
    // Save Room Images
    //----------------------------------------------------------

    if (uploadedPaths.isNotEmpty) {
      final rows = <Map<String, dynamic>>[];

      for (int i = 0; i < uploadedPaths.length; i++) {
        rows.add({
          'room_id': roomId,
          'storage_path': uploadedPaths[i],
          'display_order': i,
        });
      }

      await _supabase.from('room_images').insert(rows);
    }
  }

  //============================================================================
  //! UPDATE ROOM
  //============================================================================

  @override
  Future<void> update(RoomModel room) async {
    //----------------------------------------------------------
    // Update Room
    //----------------------------------------------------------

    await _supabase
        .from('rooms')
        .update({
          'title': room.title,
          'description': room.description,
          'price': room.price,
          'capacity': room.capacity,
          'gender_preference': room.genderPreference.toString().split('.').last,
        })
        .eq('id', room.id);

    //----------------------------------------------------------
    // Existing Images In Database
    //----------------------------------------------------------

    final existingRows = await _supabase
        .from('room_images')
        .select('storage_path')
        .eq('room_id', room.id);

    final existingStoragePaths = existingRows
        .map<String>((row) => row['storage_path'] as String)
        .toSet();

    //----------------------------------------------------------
    // Images User Kept
    //----------------------------------------------------------

    final keptStoragePaths = room.images
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

    await _supabase.from('room_images').delete().eq('room_id', room.id);

    //----------------------------------------------------------
    // Upload New Images
    //----------------------------------------------------------

    final localPaths = room.images
        .where((image) => image.isLocal)
        .map((image) => image.path)
        .toList();

    final uploadedStoragePaths = await _storageRepository.uploadRoomImages(
      roomId: room.id,
      localPaths: localPaths,
    );

    //----------------------------------------------------------
    // Rebuild Image Rows
    //----------------------------------------------------------

    final rows = <Map<String, dynamic>>[];

    int uploadedIndex = 0;

    for (int i = 0; i < room.images.length; i++) {
      final image = room.images[i];

      rows.add({
        'room_id': room.id,
        'storage_path': image.isLocal
            ? uploadedStoragePaths[uploadedIndex++]
            : image.storagePath!,
        'display_order': i,
      });
    }

    if (rows.isNotEmpty) {
      await _supabase.from('room_images').insert(rows);
    }
  }

  //============================================================================
  //! DELETE ROOM
  //============================================================================

  @override
  Future<void> delete(String roomId) async {
    //----------------------------------------------------------
    // Existing Images
    //----------------------------------------------------------

    final existingImages = await _supabase
        .from('room_images')
        .select('storage_path')
        .eq('room_id', roomId);

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
    // Delete Room
    //----------------------------------------------------------

    await _supabase.from('rooms').delete().eq('id', roomId);
  }
}
