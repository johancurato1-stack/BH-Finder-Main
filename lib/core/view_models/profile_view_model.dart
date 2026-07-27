import 'package:flutter/foundation.dart';

import 'package:bh_finder/core/repositories/profile_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  //============================================================================
  //! REPOSITORY
  //============================================================================

  final ProfileRepository _repository;

  ProfileViewModel({required ProfileRepository repository})
    : _repository = repository;

  //============================================================================
  //! STATE
  //============================================================================

  Map<String, dynamic>? _profile;

  Map<String, dynamic>? get profile => _profile;

  int _favoritesCount = 0;

  int get favoritesCount => _favoritesCount;

  int _inquiriesCount = 0;

  int get inquiriesCount => _inquiriesCount;

  int _propertiesCount = 0;

  int get propertiesCount => _propertiesCount;

  bool _loading = false;

  bool get loading => _loading;

  //============================================================================
  //! LOAD PROFILE
  //============================================================================

  Future<void> loadProfile() async {
    _loading = true;

    notifyListeners();

    _profile = await _repository.getCurrentProfile();

    _favoritesCount = await _repository.getFavoritesCount();

    _inquiriesCount = await _repository.getInquiriesCount();

    _propertiesCount = await _repository.getPropertiesCount();

    _loading = false;

    notifyListeners();
  }

  //============================================================================
  //! ROLE
  //============================================================================

  Future<void> updateLastActiveRole(String role) async {
    await _repository.updateLastActiveRole(role);

    if (_profile != null) {
      _profile!['last_active_role'] = role;

      notifyListeners();
    }
  }
}
