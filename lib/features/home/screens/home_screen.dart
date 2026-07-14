import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bh_finder/core/providers/bh_provider.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/features/home/widgets/bh_horizontal_list.dart';
import 'package:bh_finder/features/home/widgets/hero_section.dart';
import 'package:bh_finder/features/home/widgets/home_header.dart';
import 'package:bh_finder/features/home/widgets/home_search_bar.dart';
import 'package:bh_finder/features/home/widgets/section_header.dart';

import 'package:bh_finder/shared/widgets/screens/see_all_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onSearchPressed;
  final bool hasNotification;
  final VoidCallback onNotificationsRead;

  const HomeScreen({
    super.key,
    required this.onSearchPressed,
    required this.hasNotification,
    required this.onNotificationsRead,
  });

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BhProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    //============================================================================
                    //! HOME HEADER
                    //============================================================================
                    HomeHeader(
                      hasNotification: hasNotification,
                      onNotificationsRead: onNotificationsRead,
                    ),

                    const SizedBox(height: 25),

                    //============================================================================
                    //! HERO SECTION
                    //============================================================================
                    const HeroSection(),

                    const SizedBox(height: 20),

                    //============================================================================
                    //! SEARCH BAR
                    //============================================================================
                    HomeSearchBar(onTap: onSearchPressed),

                    const SizedBox(height: 25),

                    //============================================================================
                    //! NEAR YOU HEADER
                    //============================================================================
                    SectionHeader(
                      title: 'Near You',
                      onSeeAll: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    SeeAllScreen(
                                      title: 'Near You',
                                      boardingHouses: provider.nearYouList,
                                    ),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  return SlideTransition(
                                    position:
                                        Tween<Offset>(
                                          begin: const Offset(0, 1),
                                          end: Offset.zero,
                                        ).animate(
                                          CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.easeOut,
                                          ),
                                        ),
                                    child: child,
                                  );
                                },
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),

              //============================================================================
              //! BOARDING HOUSE LIST
              //============================================================================
              BhHorizontalList(boardingHouses: provider.rooms),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
