import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/mock_data/mock_boarding_houses.dart';
import 'package:bh_finder/core/data/mock_data/mock_rooms.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/core/data/models/room_model.dart';

class BoardingHouseProvider extends ChangeNotifier {
  //==========================================================================
  //! STATE
  //==========================================================================

  final List<BoardingHouseModel> _boardingHouses = mockBoardingHouses;

  //==========================================================================
  //! GETTERS
  //==========================================================================

  /// All boarding houses
  List<BoardingHouseModel> get rooms => _boardingHouses;

  /// Boarding houses shown in "Near You"
  List<BoardingHouseModel> get nearYouList => _boardingHouses;

  /// Saved boarding houses
  List<BoardingHouseModel> get savedRooms =>
      _boardingHouses.where((bh) => bh.isSaved).toList();

  //==========================================================================
  //! METHODS
  //==========================================================================

  void toggleSaved(BoardingHouseModel boardingHouse) {
    boardingHouse.isSaved = !boardingHouse.isSaved;
    notifyListeners();
  }

  List<RoomModel> getRoomsForBh(String boardingHouseId) {
    return MockRoomData.rooms
        .where((room) => room.bhId == boardingHouseId)
        .toList();
  }
}
