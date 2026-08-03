import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//============================================================================
//! AUTH STATE VIEW MODEL
//============================================================================

class AuthStateViewModel extends ChangeNotifier {
  //============================================================================
  //! FIELDS
  //============================================================================

  final SupabaseClient _supabase = Supabase.instance.client;

  Session? _session;

  AuthChangeEvent? _lastEvent;

  StreamSubscription<AuthState>? _authSubscription;

  //============================================================================
  //! GETTERS
  //============================================================================

  Session? get session => _session;

  bool get isLoggedIn => _session != null;

  String? get userId => _session?.user.id;

  AuthChangeEvent? get lastEvent => _lastEvent;

  //============================================================================
  //! INITIALIZATION
  //============================================================================

  void initialize() {
    _session = _supabase.auth.currentSession;

    _authSubscription = _supabase.auth.onAuthStateChange.listen((data) {
      _lastEvent = data.event;
      _session = data.session;

      notifyListeners();
    });
  }

  //============================================================================
  //! DISPOSE
  //============================================================================

  @override
  void dispose() {
    _authSubscription?.cancel();

    super.dispose();
  }
}
