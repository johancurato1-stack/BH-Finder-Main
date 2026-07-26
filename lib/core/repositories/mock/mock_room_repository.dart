import 'package:bh_finder/core/data/mock/rooms/mock_rooms.dart';

import 'package:bh_finder/core/models/room_model.dart';

import 'package:bh_finder/core/repositories/room_repository.dart';

import 'package:bh_finder/core/view_models/room_detail_data.dart';

//============================================================================
//! MOCK ROOM REPOSITORY
//============================================================================

class MockRoomRepository implements RoomRepository {
  //============================================================================
  //! GETTERS
  //============================================================================

  @override
  Future<List<RoomModel>> getAll() async {
    return mockRooms;
  }

  @override
  Future<RoomModel?> getById(String roomId) async {
    try {
      return mockRooms.firstWhere((room) => room.id == roomId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<RoomModel>> getByProperty(String propertyId) async {
    return mockRooms.where((room) => room.propertyId == propertyId).toList();
  }

  @override
  Future<double> getMinimumPrice(String propertyId) async {
    final rooms = await getByProperty(propertyId);

    if (rooms.isEmpty) {
      return 0;
    }

    return rooms.map((room) => room.price).reduce((a, b) => a < b ? a : b);
  }

  @override
  Future<int> getRoomCount(String propertyId) async {
    final rooms = await getByProperty(propertyId);

    return rooms.length;
  }

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
}
