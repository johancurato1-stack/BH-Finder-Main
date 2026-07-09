import 'package:bh_finder/features/search/search_screen.dart';
import 'package:bh_finder/features/profile/profile_screen.dart';
import 'package:bh_finder/features/saved/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/features/splash/splash_screen.dart';
import 'package:bh_finder/features/home/home_screen.dart';
import 'package:bh_finder/features/messages/messages_screen.dart';

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

//!======================================================================================================================================== B O T T O M  N A V I G A T I O N  H O S T
class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _currentIndex = 0;

  // Real-time local state flags for tracking red dots
  bool _hasUnreadNotifications = true;
  bool _hasUnreadLandlordMessages = true;

  // Helper logic: Tab turns red if either system updates or landlord messages are unread
  bool get _showMessagesTabBadge =>
      _hasUnreadNotifications || _hasUnreadLandlordMessages;

  @override
  Widget build(BuildContext context) {
    // Dynamic screens list rebuilt with current states on every widget refresh
    final List<Widget> screens = [
      HomeScreen(
        hasNotification: _hasUnreadNotifications, // Pass the boolean state down
        onNotificationsRead: () {
          setState(() {
            _hasUnreadNotifications =
                false; // Turns off the red dot when clicked!
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
          setState(() => _currentIndex = 0);
        },
      ),
      SavedScreen(
        onBackPressed: () {
          setState(() => _currentIndex = 0);
        },
      ),
      MessagesScreen(
        onBackPressed: () {
          setState(() => _currentIndex = 0);
        },
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 15,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.tertiary,
          selectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
          ),
          elevation: 0,
          items: [
            //* Home Icon
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),

            //* Search Icon
            const BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'Search',
            ),

            //* Saved Icon
            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded),
              activeIcon: Icon(Icons.favorite_rounded),
              label: 'Saved',
            ),

            //* Messages Icon (Wrapped in a Stack to dynamically render the badge overlay)
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.chat_bubble_outline_rounded),
                  if (_showMessagesTabBadge)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.white,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              activeIcon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.chat_bubble_rounded),
                  if (_showMessagesTabBadge)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.white,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              label: 'Messages',
            ),

            //* Profile Icon
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
