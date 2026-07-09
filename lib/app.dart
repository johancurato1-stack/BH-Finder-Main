import 'package:bh_finder/features/search/search_screen.dart';
import 'package:bh_finder/saved/saved_screen.dart';
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
      // Debug Banner
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

  // FIXED: Added the state variable declaration right here so IndexedStack can read it!
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(
        onSearchPressed: () {
          setState(() {
            _currentIndex = 1;
          });
        },
      ),
      const SearchScreen(),
      const SavedScreen(),
      const MessagesScreen(),
      const Scaffold(body: Center(child: Text('Profile Screen Workspace'))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
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
          items: const [
            //* Home Icon
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),

            //* Search Icon
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'Search',
            ),

            //* Saved Icon
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded),
              activeIcon: Icon(Icons.favorite_rounded),
              label: 'Saved',
            ),

            //* Messages Icon
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_rounded),
              activeIcon: Icon(Icons.chat_bubble_rounded),
              label: 'Messages',
            ),

            //* Profile Icon
            BottomNavigationBarItem(
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
