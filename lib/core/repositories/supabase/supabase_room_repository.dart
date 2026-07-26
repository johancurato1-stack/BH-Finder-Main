import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/models/room_model.dart';

import 'package:bh_finder/core/repositories/room_repository.dart';

import 'package:bh_finder/core/view_models/room_detail_data.dart';

//============================================================================
//! SUPABASE ROOM REPOSITORY
//============================================================================

class SupabaseRoomRepository implements RoomRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  //============================================================================
  //! GET ALL ROOMS
  //============================================================================

  @override
  Future<List<RoomModel>> getAll() async {
    final response = await _supabase.from('rooms').select('''
          *,
          room_images (
            image_path
          )
        ''');

    return response.map<RoomModel>((room) {
      return _mapRoom(room);
    }).toList();
  }

  //============================================================================
  //! GET ROOM BY ID
  //============================================================================

  @override
  Future<RoomModel?> getById(String roomId) async {
    final response = await _supabase
        .from('rooms')
        .select('''
          *,
          room_images (
            storage_path
          )
        ''')
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
    final response = await _supabase
        .from('rooms')
        .select('''
          *,
          room_images (
            storage_path
          )
        ''')
        .eq('property_id', propertyId);

    return response.map<RoomModel>((room) {
      return _mapRoom(room);
    }).toList();
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
    final room = await getById(roomId);

    if (room == null) {
      throw Exception('Room not found.');
    }

    return RoomDetailData(
      id: room.id,

      propertyId: room.propertyId,

      roomNumber: room.roomNumber,

      description: room.description,

      price: room.price,

      capacity: room.capacity,

      genderPreference: room.genderPreference,

      imageUrls: room.imageUrls,
    );
  }

  //============================================================================
  //! MAPPER
  //============================================================================

  RoomModel _mapRoom(Map<String, dynamic> room) {
    return RoomModel(
      id: room['id'],

      propertyId: room['property_id'],

      roomNumber: room['title'],

      description: room['description'] ?? '',

      price: (room['price'] as num).toDouble(),

      capacity: room['capacity'],

      genderPreference: room['gender_preference'] == 'male'
          ? GenderPreference.male
          : GenderPreference.female,

      imageUrls: (room['room_images'] as List<dynamic>)
          .map((image) => image['storage_path'] as String)
          .toList(),
    );
  }
}
