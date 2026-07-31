import 'package:flutter/foundation.dart';

import 'package:bh_finder/core/authentication/repositories/auth_repository.dart';
import 'package:bh_finder/core/repositories/profile_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/storage_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  //============================================================================
  //! REPOSITORIES
  //============================================================================

  final ProfileRepository _repository;

  final StorageRepository _storageRepository;

  final AuthRepository _authRepository;

  ProfileViewModel({
    required ProfileRepository repository,
    required StorageRepository storageRepository,
    required AuthRepository authRepository,
  }) : _repository = repository,
       _storageRepository = storageRepository,
       _authRepository = authRepository;

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
  //! AVATAR
  //============================================================================

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
