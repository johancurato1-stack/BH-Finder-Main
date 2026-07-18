import 'package:bh_finder/core/data/mock/rooms/mock_rooms.dart';
import 'package:bh_finder/core/models/room_model.dart';
import 'package:bh_finder/core/view_models/room_detail_data.dart';

//============================================================================
//! ROOM REPOSITORY
//============================================================================

class RoomRepository {
  //============================================================================
  //! GETTERS
  //============================================================================

  /// Returns all rooms.
  List<RoomModel> getAll() {
    return mockRooms;
  }

  /// Returns a room by its ID.
  RoomModel? getById(String roomId) {
    try {
      return mockRooms.firstWhere((room) => room.id == roomId);
    } catch (_) {
      return null;
    }
  }

  /// Returns all rooms belonging to a property.
  List<RoomModel> getByProperty(String propertyId) {
    return mockRooms.where((room) => room.propertyId == propertyId).toList();
  }

  /// Returns the lowest room price for a property.
  double getMinimumPrice(String propertyId) {
    final rooms = getByProperty(propertyId);

    if (rooms.isEmpty) return 0;

    return rooms.map((room) => room.price).reduce((a, b) => a < b ? a : b);
  }

  /// Returns the total number of rooms in a property.
  int getRoomCount(String propertyId) {
    return getByProperty(propertyId).length;
  }

  /// Returns data used by the room detail screen.
  RoomDetailData getRoomDetail(String roomId) {
    final room = getById(roomId);

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
