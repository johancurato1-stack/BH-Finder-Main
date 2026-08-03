import 'package:flutter/foundation.dart';

import 'package:bh_finder/core/repositories/repositories/auth_repository.dart';
import 'package:bh_finder/core/repositories/repositories/profile_repository.dart';
import 'package:bh_finder/core/repositories/repositories/storage_repository.dart';

//============================================================================
//! PROFILE VIEW MODEL
//============================================================================

class ProfileViewModel extends ChangeNotifier {
  //============================================================================
  //! FIELDS
  //============================================================================

  final ProfileRepository _repository;

  final StorageRepository _storageRepository;

  final AuthRepository _authRepository;

  Map<String, dynamic>? _profile;

  int _favoritesCount = 0;

  int _inquiriesCount = 0;

  int _propertiesCount = 0;

  bool _isLoading = false;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  ProfileViewModel({
    required ProfileRepository repository,
    required StorageRepository storageRepository,
    required AuthRepository authRepository,
  }) : _repository = repository,
       _storageRepository = storageRepository,
       _authRepository = authRepository;

  //============================================================================
  //! GETTERS
  //============================================================================

  Map<String, dynamic>? get profile => _profile;

  int get favoritesCount => _favoritesCount;

  int get inquiriesCount => _inquiriesCount;

  int get propertiesCount => _propertiesCount;

  bool get isLoading => _isLoading;

  //============================================================================
  //! COMMANDS
  //============================================================================

  Future<void> loadProfile() async {
    _setLoading(true);

    _profile = await _repository.getCurrentProfile();

    _favoritesCount = await _repository.getFavoritesCount();

    _inquiriesCount = await _repository.getInquiriesCount();

    _propertiesCount = await _repository.getPropertiesCount();

    _setLoading(false);
  }

  Future<void> updateAvatar({required String localPath}) async {
    final userId = _authRepository.currentUserId;

    if (userId == null) {
      throw Exception('No authenticated user.');
    }

    final avatarPath = await _storageRepository.uploadAvatar(
      userId: userId,
      localPath: localPath,
    );

    await _repository.updateAvatarPath(avatarPath);

    await loadProfile();
  }

  Future<void> updateLastActiveRole(String role) async {
    await _repository.updateLastActiveRole(role);

    if (_profile != null) {
      _profile!['last_active_role'] = role;

      _notify();
    }
  }

  //============================================================================
  //! PRIVATE METHODS
  //============================================================================

  void _setLoading(bool value) {
    _isLoading = value;

    _notify();
  }

  void _notify() {
    notifyListeners();
  }
}
