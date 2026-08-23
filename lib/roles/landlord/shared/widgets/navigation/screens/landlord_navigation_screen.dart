import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bh_finder/core/repositories/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories/repositories.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/screens/dashboard_screen.dart';
import 'package:bh_finder/roles/landlord/features/messages/screens/messages_screen.dart';
import 'package:bh_finder/roles/landlord/features/profile/screens/profile_screen.dart';
import 'package:bh_finder/roles/landlord/features/properties/screens/properties_screen.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/navigation/widgets/landlord_bottom_navigation_bar.dart';

//============================================================================
//! LANDLORD NAVIGATION SCREEN
//============================================================================

class LandlordNavigationScreen extends StatefulWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const LandlordNavigationScreen({super.key});

  @override
  State<LandlordNavigationScreen> createState() =>
      _LandlordNavigationScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _LandlordNavigationScreenState extends State<LandlordNavigationScreen> {
  //==========================================================================
  //! REPOSITORIES
  //==========================================================================

  final PropertyRepository _propertyRepository =
      Repositories.instance.propertyRepository;

  //==========================================================================
  //! STATE
  //==========================================================================

  int _currentIndex = 0;

  //==========================================================================
  //! PROPERTY REFRESH
  //==========================================================================

  final ValueNotifier<int> _propertyRefreshNotifier = ValueNotifier<int>(0);

  //==========================================================================
  //! NAVIGATION
  //==========================================================================

  void _navigateTo(int index) {
    if (_currentIndex == index) return;

    HapticFeedback.selectionClick();

    setState(() {
      _currentIndex = index;
    });
  }

  void _goToDashboard() => _navigateTo(0);

  //==========================================================================
  //! DISPOSE
  //==========================================================================

  @override
  void dispose() {
    _propertyRefreshNotifier.dispose();

    super.dispose();
  }

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      DashboardScreen(propertyRefreshNotifier: _propertyRefreshNotifier),

      PropertiesScreen(
        onBackPressed: _goToDashboard,
        propertyRepository: _propertyRepository,
        propertyRefreshNotifier: _propertyRefreshNotifier,
      ),

      MessagesScreen(onBackPressed: _goToDashboard),

      ProfileScreen(onNavigateToTab: _navigateTo),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: LandlordBottomNavigationBar(
        currentIndex: _currentIndex,
        showMessagesBadge: false,
        onTap: _navigateTo,
      ),
    );
  }
}
