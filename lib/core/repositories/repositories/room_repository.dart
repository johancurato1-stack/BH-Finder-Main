import 'package:bh_finder/core/models/room_model.dart';
import 'package:bh_finder/core/models/room_search_filter_model.dart';
import 'package:bh_finder/core/ui_models/room_detail_data.dart';

//============================================================================
//! ROOM REPOSITORY
//============================================================================

abstract class RoomRepository {
  //============================================================================
  //! GETTERS
  //============================================================================

  /// Returns all rooms.
  Future<List<RoomModel>> getAll();

  /// Returns a room by its ID.
  Future<RoomModel?> getById(String roomId);

  /// Returns all rooms belonging to a property.
  Future<List<RoomModel>> getByProperty(String propertyId);

  /// Returns the lowest room price for a property.
  Future<double> getMinimumPrice(String propertyId);

  /// Returns the total number of rooms in a property.
  Future<int> getRoomCount(String propertyId);

  /// Returns the data used by the room detail screen.
  Future<RoomDetailData> getRoomDetail(String roomId);

  /// Returns filtered rooms belonging to a property.
  Future<List<RoomModel>> searchRooms({
    required String propertyId,
    required RoomSearchFilterModel filter,
  });

  //============================================================================
  //! COMMANDS
  //============================================================================

  /// Creates a room.
  Future<void> create(RoomModel room);

  /// Updates a room.
  Future<void> update(RoomModel room);

  /// Deletes a room.
  Future<void> delete(String roomId);
}
