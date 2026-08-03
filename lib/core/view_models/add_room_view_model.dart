import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/models/add_room_request.dart';
import 'package:bh_finder/core/models/room_model.dart';

import 'package:bh_finder/core/repositories/repositories/room_repository.dart';

//============================================================================
//! ADD ROOM VIEW MODEL
//============================================================================

class AddRoomViewModel extends ChangeNotifier {
  //============================================================================
  //! FIELDS
  //============================================================================

  final RoomRepository _roomRepository;

  bool _isLoading = false;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  AddRoomViewModel({required RoomRepository roomRepository})
    : _roomRepository = roomRepository;

  //============================================================================
  //! GETTERS
  //============================================================================

  bool get isLoading => _isLoading;

  //============================================================================
  //! COMMANDS
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
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _roomRepository.create(room);

      return true;
    } catch (_) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

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
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
      );

      await _roomRepository.update(room);

      return true;
    } catch (_) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteRoom(String roomId) async {
    _setLoading(true);

    try {
      await _roomRepository.delete(roomId);

      return true;
    } catch (_) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  AddRoomValidationResult validate({
    required int photoCount,
    required String title,
    required double price,
    required int capacity,
    required String description,
    required GenderPreference? gender,
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

    if (description.trim().isEmpty) {
      return AddRoomValidationResult.description;
    }

    if (gender == null) {
      return AddRoomValidationResult.gender;
    }

    return AddRoomValidationResult.success;
  }

  //============================================================================
  //! PRIVATE METHODS
  //============================================================================

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
