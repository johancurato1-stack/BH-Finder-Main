import 'package:bh_finder/core/models/room_model.dart';
import 'package:bh_finder/core/view_models/room_detail_data.dart';

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

  /// Returns data used by the room detail screen.
  Future<RoomDetailData> getRoomDetail(String roomId);
}
