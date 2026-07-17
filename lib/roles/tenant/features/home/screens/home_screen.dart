import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bh_finder/core/providers/boarding_house_provider.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_%20property_horizontal_list.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_hero_section.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_header.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_search_bar.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_section_header.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/see_all_screen/see_all_screen.dart';

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
    final provider = context.watch<BoardingHouseProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.xl),

                    //============================================================================
                    //! HOME HEADER
                    //============================================================================
                    HomeScreenHeader(
                      hasNotification: hasNotification,
                      onNotificationsRead: onNotificationsRead,
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    //============================================================================
                    //! HERO SECTION
                    //============================================================================
                    const HomeScreenHeroSection(),

                    const SizedBox(height: AppSpacing.xl),

                    //============================================================================
                    //! SEARCH BAR
                    //============================================================================
                    HomeScreenSearchBar(onTap: onSearchPressed),

                    const SizedBox(height: AppSpacing.xxl),

                    //============================================================================
                    //! NEAR YOU HEADER
                    //============================================================================
                    HomeScreenSectionHeader(
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

                    const SizedBox(height: AppSpacing.md),
                  ],
                ),
              ),

              //============================================================================
              //! BOARDING HOUSE LIST
              //============================================================================
              HomeScreenPropertyHorizontalList(
                boardingHouses: provider.boardingHouses,
              ),

              const SizedBox(height: AppSpacing.xxxl),
            ],
          ),
        ),
      ),
    );
  }
}
