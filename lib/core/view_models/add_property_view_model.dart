import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/models/add_property_request.dart';
import 'package:bh_finder/core/models/property_model.dart';

import 'package:bh_finder/core/repositories/repositories/property_repository.dart';

//============================================================================
//! ADD PROPERTY VIEW MODEL
//============================================================================

class AddPropertyViewModel extends ChangeNotifier {
  //============================================================================
  //! FIELDS
  //============================================================================

  final PropertyRepository _propertyRepository;

  bool _isLoading = false;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  AddPropertyViewModel({required PropertyRepository propertyRepository})
    : _propertyRepository = propertyRepository;

  //============================================================================
  //! GETTERS
  //============================================================================

  bool get isLoading => _isLoading;

  //============================================================================
  //! COMMANDS
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
        minimumPrice: 0,
        genderPreference: GenderPreference.mixed,
        views: 0,
        status: request.status,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _propertyRepository.create(property);

      return true;
    } catch (_) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

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
        minimumPrice: existing.minimumPrice,
        genderPreference: existing.genderPreference,
        views: existing.views,
        status: request.status,
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
      );

      await _propertyRepository.update(property);

      return true;
    } catch (_) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

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
  //! PRIVATE METHODS
  //============================================================================

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
