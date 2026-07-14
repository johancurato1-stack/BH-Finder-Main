import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/features/home/screens/home_screen.dart';
import 'package:bh_finder/features/messages/messages_screen.dart';
import 'package:bh_finder/features/profile/profile_screen.dart';
import 'package:bh_finder/features/saved/screens/saved_screen.dart';
import 'package:bh_finder/features/search/screens/search_screen.dart';
import 'package:bh_finder/features/splash/screens/splash_screen.dart';

import 'package:bh_finder/shared/widgets/navigation/app_bottom_navigation_bar.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(scaffoldBackgroundColor: AppColors.background),

      home: const SplashScreen(),
    );
  }
}

//============================================================================
//! MAIN NAVIGATION WRAPPER
//============================================================================

class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
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
      ),

      SearchScreen(
        onBackPressed: () {
          setState(() {
            _currentIndex = 0;
          });
        },
      ),

      SavedScreen(
        onBackPressed: () {
          setState(() {
            _currentIndex = 0;
          });
        },
      ),

      MessagesScreen(
        onBackPressed: () {
          setState(() {
            _currentIndex = 0;
          });
        },
      ),

      const ProfileScreen(),
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
