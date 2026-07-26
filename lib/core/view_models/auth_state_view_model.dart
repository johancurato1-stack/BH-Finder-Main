import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthStateViewModel extends ChangeNotifier {
  //============================================================================
  //! SUPABASE
  //============================================================================

  final SupabaseClient _supabase = Supabase.instance.client;

  //============================================================================
  //! STATE
  //============================================================================

  Session? _session;

  Session? get session => _session;

  bool get isLoggedIn => _session != null;

  String? get userId => _session?.user.id;

  //============================================================================
  //! LISTENER
  //============================================================================

  StreamSubscription<AuthState>? _authSubscription;

  //============================================================================
  //! INITIALIZE
  //============================================================================

  void initialize() {
    print('AUTH VIEW MODEL INITIALIZED');

    _session = _supabase.auth.currentSession;

    print('CURRENT SESSION: $_session');

    _authSubscription = _supabase.auth.onAuthStateChange.listen((data) {
      print('============================');
      print('AUTH EVENT: ${data.event}');
      print('SESSION: ${data.session}');
      print('============================');

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
