import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/profile_repository.dart';
import 'package:bh_finder/core/repositories/supabase/supabase_profile_repository.dart';

import 'package:bh_finder/core/authentication/view_models/auth_state_view_model.dart';

import 'package:bh_finder/roles/tenant/features/auth/login/screens/login_screen.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/navigation/screens/tenant_navigation_screen.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/navigation/screens/landlord_navigation_screen.dart';
import 'package:bh_finder/roles/tenant/features/auth/forgot_password/screens/reset_password_screen.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bh_finder/shared/widgets/splash/screens/loading_screen.dart';

class AuthCoordinator extends StatefulWidget {
  const AuthCoordinator({super.key});

  @override
  State<AuthCoordinator> createState() => _AuthCoordinatorState();
}

class _AuthCoordinatorState extends State<AuthCoordinator> {
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
  //! PASSWORD RECOVERY
  //============================================================================

  bool _handledPasswordRecovery = false;

  //============================================================================
  //! AUTH LISTENER
  //============================================================================

  void _listenAuthChanges() {
    _authListener = () async {
      if (_authViewModel.lastEvent == AuthChangeEvent.passwordRecovery) {
        _handlePasswordRecovery();
        return;
      }

      await _checkSession();
    };

    _authViewModel.addListener(_authListener!);
  }

  //============================================================================
  //! PASSWORD RECOVERY
  //============================================================================

  void _handlePasswordRecovery() {
    if (_authViewModel.lastEvent != AuthChangeEvent.passwordRecovery) {
      _handledPasswordRecovery = false;
      return;
    }

    if (_handledPasswordRecovery) {
      return;
    }

    _handledPasswordRecovery = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const ResetPasswordScreen()));
    });
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

    setState(() {
      _loading = true;
    });

    if (!_authViewModel.isLoggedIn) {
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      setState(() {
        _role = null;
        _loading = false;
      });

      return;
    }

    try {
      final profile = await _profileRepository.getCurrentProfile();

      if (!mounted) return;

      setState(() {
        _role = profile?['last_active_role'];
        _loading = false;
      });
    } catch (e, stackTrace) {
      if (!mounted) return;

      setState(() {
        _loading = false;
      });
    }
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
          return const LoadingScreen();
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
          return const LoadingScreen();
        }

        //======================================================================
        //! ROLE ROUTING
        //======================================================================

        switch (_role) {
          case 'tenant':
            return const TenantNavigationScreen();

          case 'landlord':
            return const LandlordNavigationScreen();

          default:
            return const Scaffold(body: Center(child: Text('Unknown Role')));
        }
      },
    );
  }
}
