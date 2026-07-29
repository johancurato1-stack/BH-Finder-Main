import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/models/add_property_request.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/models/property_model.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';

//============================================================================
//! ADD PROPERTY VALIDATION RESULT
//============================================================================

enum AddPropertyValidationResult { success, photos, title, location, amenities }

//============================================================================
//! ADD PROPERTY VIEW MODEL
//============================================================================

class AddPropertyViewModel extends ChangeNotifier {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  AddPropertyViewModel({required PropertyRepository propertyRepository})
    : _propertyRepository = propertyRepository;

  //============================================================================
  //! REPOSITORY
  //============================================================================

  final PropertyRepository _propertyRepository;

  //============================================================================
  //! STATE
  //============================================================================

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  //============================================================================
  //! CREATE PROPERTY
  //============================================================================

  Future<bool> createProperty(AddPropertyRequest request) async {
    _setLoading(true);

    try {
      final property = PropertyModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        landlordId: '',
        title: request.title,
        description: request.description,
        address: request.address,
        latitude: request.latitude,
        longitude: request.longitude,
        images: request.images,
        amenities: request.amenities,
        genderPreference: GenderPreference.mixed,
        views: 0,
        status: request.status,
      );

      await _propertyRepository.create(property);

      return true;
    } catch (_) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  //============================================================================
  //! UPDATE PROPERTY
  //============================================================================

  Future<bool> updateProperty({
    required String propertyId,
    required AddPropertyRequest request,
  }) async {
    _setLoading(true);

    try {
      final existing = await _propertyRepository.getById(propertyId);

      if (existing == null) {
        return false;
      }

      final property = PropertyModel(
        id: existing.id,
        landlordId: existing.landlordId,
        title: request.title,
        description: request.description,
        address: request.address,
        latitude: request.latitude,
        longitude: request.longitude,
        images: request.images,
        amenities: request.amenities,
        genderPreference: existing.genderPreference,
        views: existing.views,
        status: request.status,
      );

      await _propertyRepository.update(property);

      return true;
    } catch (_) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  //============================================================================
  //! DELETE PROPERTY
  //============================================================================

  Future<bool> deleteProperty(String propertyId) async {
    _setLoading(true);

    try {
      await _propertyRepository.delete(propertyId);

      return true;
    } catch (_) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  //============================================================================
  //! VALIDATE PROPERTY
  //============================================================================

  AddPropertyValidationResult validate({
    required int photoCount,
    required String title,
    required bool hasLocation,
    required int amenityCount,
  }) {
    if (photoCount < 3) {
      return AddPropertyValidationResult.photos;
    }

    if (title.trim().length < 8) {
      return AddPropertyValidationResult.title;
    }

    if (!hasLocation) {
      return AddPropertyValidationResult.location;
    }

    if (amenityCount < 3) {
      return AddPropertyValidationResult.amenities;
    }

    return AddPropertyValidationResult.success;
  }

  //============================================================================
  //! SET LOADING
  //============================================================================

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
