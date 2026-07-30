import 'package:flutter/material.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';
import 'package:bh_finder/core/favorites/respositories/favorite_repository.dart';

import 'package:bh_finder/roles/tenant/features/favorites/screens/favorites_screen.dart';
import 'package:bh_finder/roles/tenant/features/home/screens/home_screen.dart';
import 'package:bh_finder/roles/tenant/features/messages/screens/messages_screen.dart';
import 'package:bh_finder/roles/tenant/features/profile/screens/profile_screen.dart';
import 'package:bh_finder/roles/tenant/features/search/screens/search_screen.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/navigation/widgets/app_bottom_navigation_bar.dart';

//============================================================================
//! TENANT NAVIGATION SCREEN
//============================================================================

class TenantNavigationScreen extends StatefulWidget {
  const TenantNavigationScreen({super.key});

  @override
  State<TenantNavigationScreen> createState() =>
      _TenantNavigationWrapperState();
}

class _TenantNavigationWrapperState extends State<TenantNavigationScreen> {
  //============================================================================
  //! REPOSITORIES
  //============================================================================

  final PropertyRepository _propertyRepository =
      Repositories.instance.propertyRepository;

  final RoomRepository _roomRepository = Repositories.instance.roomRepository;

  final FavoriteRepository _favoriteRepository =
      Repositories.instance.favoriteRepository;

  //============================================================================
  //! STATE
  //============================================================================

  int _currentIndex = 0;

  bool _hasUnreadNotifications = true;

  bool _hasUnreadLandlordMessages = true;

  bool get _showMessagesTabBadge =>
      _hasUnreadNotifications || _hasUnreadLandlordMessages;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        hasNotification: _hasUnreadNotifications,
        onNotificationsRead: () {
          setState(() {
            _hasUnreadNotifications = false;
          });
        },
        onSearchPressed: () {
          setState(() {
            _currentIndex = 1;
          });
        },
        propertyRepository: _propertyRepository,
        roomRepository: _roomRepository,
        favoriteRepository: _favoriteRepository,
      ),

      SearchScreen(
        onBackPressed: () {
          setState(() {
            _currentIndex = 0;
          });
        },
        propertyRepository: _propertyRepository,
        roomRepository: _roomRepository,
        favoriteRepository: _favoriteRepository,
      ),

      FavoritesScreen(
        onBackPressed: () {
          setState(() {
            _currentIndex = 0;
          });
        },
        propertyRepository: _propertyRepository,
        roomRepository: _roomRepository,
        favoriteRepository: _favoriteRepository,
      ),

      MessagesScreen(
        onBackPressed: () {
          setState(() {
            _currentIndex = 0;
          });
        },
      ),

      ProfileScreen(
        onNavigateToTab: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _currentIndex,
        showMessagesBadge: _showMessagesTabBadge,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
