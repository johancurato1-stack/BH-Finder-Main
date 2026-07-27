import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/property_model.dart';

import 'package:bh_finder/core/repositories/property_repository.dart';

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

  Future<bool> createProperty(PropertyModel property) async {
    _setLoading(true);

    try {
      await _propertyRepository.create(property);
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
