import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:bh_finder/core/repositories/repositories/profile_repository.dart';

//============================================================================
//! PRESENCE SERVICE
//============================================================================

class PresenceService with WidgetsBindingObserver {
  //============================================================================
  //! FIELDS
  //============================================================================

  final ProfileRepository _profileRepository;

  Timer? _heartbeatTimer;

  bool _isStarted = false;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  PresenceService({required ProfileRepository profileRepository})
    : _profileRepository = profileRepository;

  //============================================================================
  //! START
  //============================================================================

  Future<void> start() async {
    if (_isStarted) {
      return;
    }

    _isStarted = true;

    WidgetsBinding.instance.addObserver(this);

    await _profileRepository.updateLastSeen();

    _startHeartbeat();
  }

  //============================================================================
  //! STOP
  //============================================================================

  void stop() {
    if (!_isStarted) {
      return;
    }

    _isStarted = false;

    WidgetsBinding.instance.removeObserver(this);

    _heartbeatTimer?.cancel();
  }

  //============================================================================
  //! APP LIFECYCLE
  //============================================================================

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _profileRepository.updateLastSeen();
    }
  }

  //============================================================================
  //! HEARTBEAT
  //============================================================================

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();

    _heartbeatTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      _profileRepository.updateLastSeen();
    });
  }
}
