import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bh_finder/core/repositories/repositories/favorite_repository.dart';
import 'package:bh_finder/core/repositories/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories/repositories.dart';
import 'package:bh_finder/core/repositories/repositories/room_repository.dart';

import 'package:bh_finder/roles/tenant/features/favorites/screens/favorites_screen.dart';
import 'package:bh_finder/roles/tenant/features/home/screens/home_screen.dart';
import 'package:bh_finder/roles/tenant/features/messages/screens/messages_screen.dart';
import 'package:bh_finder/roles/tenant/features/profile/screens/profile_screen.dart';
import 'package:bh_finder/roles/tenant/features/search/screens/search_screen.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/navigation/widgets/tenant_bottom_navigation_bar.dart';

//============================================================================
//! TENANT NAVIGATION SCREEN
//============================================================================

class TenantNavigationScreen extends StatefulWidget {
  const TenantNavigationScreen({super.key});

  @override
  State<TenantNavigationScreen> createState() => _TenantNavigationScreenState();
}

class _TenantNavigationScreenState extends State<TenantNavigationScreen> {
  //============================================================================
  //! REPOSITORIES
  //============================================================================

  final PropertyRepository _propertyRepository =
      Repositories.instance.propertyRepository;

  final RoomRepository _roomRepository = Repositories.instance.roomRepository;

  final FavoriteRepository _favoriteRepository =
      Repositories.instance.favoriteRepository;

  //============================================================================
  //! KEYS
  //============================================================================

  final GlobalKey<SearchScreenState> _searchScreenKey =
      GlobalKey<SearchScreenState>();

  //============================================================================
  //! STATE
  //============================================================================

  int _currentIndex = 0;

  bool _hasUnreadNotifications = true;

  bool _hasUnreadLandlordMessages = true;

  bool get _showMessagesTabBadge =>
      _hasUnreadNotifications || _hasUnreadLandlordMessages;

  //============================================================================
  //! NAVIGATION
  //============================================================================

  void _navigateTo(int index) {
    if (_currentIndex == index) return;

    HapticFeedback.selectionClick();

    setState(() {
      _currentIndex = index;
    });
  }

  void _goHome() {
    _navigateTo(0);
  }

  void _markNotificationsRead() {
    if (!_hasUnreadNotifications) return;

    setState(() {
      _hasUnreadNotifications = false;
    });
  }

  void _onTabSelected(int index) {
    if (_currentIndex == 1 && index != 1) {
      _searchScreenKey.currentState?.resetSearch();
    }

    _navigateTo(index);
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      HomeScreen(
        hasNotification: _hasUnreadNotifications,
        onNotificationsRead: _markNotificationsRead,
        onSearchPressed: () => _navigateTo(1),
        propertyRepository: _propertyRepository,
        roomRepository: _roomRepository,
        favoriteRepository: _favoriteRepository,
      ),

      SearchScreen(
        key: _searchScreenKey,
        onBackPressed: () {
          _searchScreenKey.currentState?.resetSearch();
          _goHome();
        },
        propertyRepository: _propertyRepository,
        roomRepository: _roomRepository,
        favoriteRepository: _favoriteRepository,
      ),

      FavoritesScreen(
        onBackPressed: _goHome,
        propertyRepository: _propertyRepository,
        roomRepository: _roomRepository,
        favoriteRepository: _favoriteRepository,
      ),

      MessagesScreen(onBackPressed: _goHome),

      ProfileScreen(onNavigateToTab: _navigateTo),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: TenantBottomNavigationBar(
        currentIndex: _currentIndex,
        showMessagesBadge: _showMessagesTabBadge,
        onTap: _onTabSelected,
      ),
    );
  }
}
