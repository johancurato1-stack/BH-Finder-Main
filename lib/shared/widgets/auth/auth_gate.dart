import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/profile_repository.dart';
import 'package:bh_finder/core/repositories/supabase/supabase_profile_repository.dart';

import 'package:bh_finder/core/view_models/auth_state_view_model.dart';

import 'package:bh_finder/roles/tenant/features/auth/login/screens/login_screen.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/navigation/screens/tenant_navigation_screen.dart';
import 'package:bh_finder/shared/widgets/splash/screens/splash_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  //============================================================================
  //! VIEW MODELS / REPOSITORIES
  //============================================================================

  final AuthStateViewModel _authViewModel = AuthStateViewModel();

  final ProfileRepository _profileRepository = SupabaseProfileRepository();

  //============================================================================
  //! STATE
  //============================================================================

  bool _loading = true;

  String? _role;

  VoidCallback? _authListener;

  //============================================================================
  //! AUTH LISTENER
  //============================================================================

  void _listenAuthChanges() {
    _authListener = () async {
      await _checkSession();
    };

    _authViewModel.addListener(_authListener!);
  }

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _authViewModel.initialize();

    _listenAuthChanges();

    _checkSession();
  }

  Future<void> _checkSession() async {
    if (!mounted) return;

    //==========================================================================
    //! LOGGED OUT
    //==========================================================================

    if (!_authViewModel.isLoggedIn) {
      setState(() {
        _role = null;
        _loading = true;
      });

      await Future.delayed(const Duration(milliseconds: 800));

      if (!mounted) return;

      setState(() {
        _loading = false;
      });

      return;
    }

    //==========================================================================
    //! LOGGED IN
    //==========================================================================

    setState(() {
      _loading = true;
    });

    final profile = await _profileRepository.getCurrentProfile();

    if (!mounted) return;

    setState(() {
      _role = profile?['last_active_role'];

      _loading = false;
    });
  }

  @override
  void dispose() {
    if (_authListener != null) {
      _authViewModel.removeListener(_authListener!);
    }

    _authViewModel.dispose();

    super.dispose();
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _authViewModel,

      builder: (context, _) {
        //======================================================================
        //! LOADING
        //======================================================================

        if (_loading) {
          return const SplashScreen(destination: LoginScreen());
        }

        //======================================================================
        //! NO SESSION
        //======================================================================

        if (!_authViewModel.isLoggedIn) {
          return const LoginScreen();
        }

        //======================================================================
        //! WAITING FOR PROFILE
        //======================================================================

        if (_role == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        //======================================================================
        //! ROLE ROUTING
        //======================================================================

        switch (_role) {
          case 'tenant':
            return const TenantNavigationScreen();

          case 'landlord':
            return const Scaffold(
              body: Center(child: Text('Landlord Dashboard')),
            );

          default:
            return const Scaffold(body: Center(child: Text('Unknown Role')));
        }
      },
    );
  }
}
