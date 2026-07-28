import 'package:flutter/material.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories.dart';

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
  //! VARIABLES
  //==========================================================================

  int _currentIndex = 0;

  //==========================================================================
  //! METHODS
  //==========================================================================

  void _goToDashboard() {
    setState(() {
      _currentIndex = 0;
    });
  }

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    final screens = [
      const DashboardScreen(),

      PropertiesScreen(
        onBackPressed: _goToDashboard,
        propertyRepository: _propertyRepository,
      ),

      MessagesScreen(onBackPressed: _goToDashboard),

      ProfileScreen(
        onNavigateToTab: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: LandlordBottomNavigationBar(
        currentIndex: _currentIndex,
        showMessagesBadge: false,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
