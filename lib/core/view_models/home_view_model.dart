import 'package:flutter/foundation.dart';

import 'package:bh_finder/core/repositories/repositories/property_repository.dart';
import 'package:bh_finder/core/ui_models/tenant_property_card_data.dart';

//============================================================================
//! HOME VIEW MODEL
//============================================================================

class HomeViewModel extends ChangeNotifier {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  HomeViewModel({required PropertyRepository propertyRepository})
    : _propertyRepository = propertyRepository;

  //============================================================================
  //! REPOSITORY
  //============================================================================

  final PropertyRepository _propertyRepository;

  //============================================================================
  //! STATE
  //============================================================================

  List<TenantPropertyCardData> _properties = [];

  bool _isLoading = false;

  bool _isRefreshing = false;

  String? _errorMessage;

  //============================================================================
  //! GETTERS
  //============================================================================

  List<TenantPropertyCardData> get properties => List.unmodifiable(_properties);

  bool get isLoading => _isLoading;

  bool get isRefreshing => _isRefreshing;

  String? get errorMessage => _errorMessage;

  bool get hasProperties => _properties.isNotEmpty;

  //============================================================================
  //! INITIAL LOAD
  //============================================================================

  Future<void> loadProperties() async {
    if (_properties.isNotEmpty || _isLoading) {
      return;
    }

    _isLoading = true;
    _errorMessage = null;

    notifyListeners();

    try {
      final properties = await _propertyRepository.getPropertyCards();

      properties.shuffle();

      _properties = properties;
    } catch (e) {
      _errorMessage = 'Failed to load properties.';
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  //============================================================================
  //! REFRESH
  //============================================================================

  Future<void> refreshProperties() async {
    if (_isRefreshing) {
      return;
    }

    _isRefreshing = true;
    _errorMessage = null;

    notifyListeners();

    try {
      final properties = await _propertyRepository.getPropertyCards();

      properties.shuffle();

      _properties = properties;
    } catch (e) {
      _errorMessage = 'Failed to refresh properties.';
    } finally {
      _isRefreshing = false;

      notifyListeners();
    }
  }

  //============================================================================
  //! CLEAR
  //============================================================================

  void clearProperties() {
    _properties = [];

    _errorMessage = null;

    notifyListeners();
  }
}
