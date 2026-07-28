import 'package:flutter/material.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/models/add_room_request.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/models/room_model.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';

//============================================================================
//! ADD ROOM VALIDATION RESULT
//============================================================================

enum AddRoomValidationResult { success, photos, title, price, capacity }

//============================================================================
//! ADD ROOM VIEW MODEL
//============================================================================

class AddRoomViewModel extends ChangeNotifier {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  AddRoomViewModel({required RoomRepository roomRepository})
    : _roomRepository = roomRepository;

  //============================================================================
  //! REPOSITORY
  //============================================================================

  final RoomRepository _roomRepository;

  //============================================================================
  //! STATE
  //============================================================================

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  //============================================================================
  //! CREATE ROOM
  //============================================================================

  Future<bool> createRoom(AddRoomRequest request) async {
    _setLoading(true);

    try {
      final room = RoomModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        propertyId: request.propertyId,
        title: request.roomNumber,
        description: request.description,
        price: request.price,
        capacity: request.capacity,
        genderPreference: request.genderPreference,
        images: request.images,
      );

      await _roomRepository.create(room);

      return true;
    } catch (_) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  //============================================================================
  //! UPDATE ROOM
  //============================================================================

  Future<bool> updateRoom({
    required String roomId,
    required AddRoomRequest request,
  }) async {
    _setLoading(true);

    try {
      final existing = await _roomRepository.getById(roomId);

      if (existing == null) {
        return false;
      }

      final room = RoomModel(
        id: existing.id,
        propertyId: existing.propertyId,
        title: request.roomNumber,
        description: request.description,
        price: request.price,
        capacity: request.capacity,
        genderPreference: request.genderPreference,
        images: request.images,
      );

      await _roomRepository.update(room);

      return true;
    } catch (_) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  //============================================================================
  //! VALIDATE ROOM
  //============================================================================

  AddRoomValidationResult validate({
    required int photoCount,
    required String title,
    required double price,
    required int capacity,
  }) {
    if (photoCount < 1) {
      return AddRoomValidationResult.photos;
    }

    if (title.trim().isEmpty) {
      return AddRoomValidationResult.title;
    }

    if (price <= 0) {
      return AddRoomValidationResult.price;
    }

    if (capacity <= 0) {
      return AddRoomValidationResult.capacity;
    }

    return AddRoomValidationResult.success;
  }

  //============================================================================
  //! SET LOADING
  //============================================================================

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
