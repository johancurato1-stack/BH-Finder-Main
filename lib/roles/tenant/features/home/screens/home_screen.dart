import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bh_finder/core/providers/boarding_house_provider.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/features/home/widgets/bh_horizontal_list.dart';
import 'package:bh_finder/roles/tenant/features/home/widgets/hero_section.dart';
import 'package:bh_finder/roles/tenant/features/home/widgets/home_header.dart';
import 'package:bh_finder/roles/tenant/features/home/widgets/home_search_bar.dart';
import 'package:bh_finder/roles/tenant/features/home/widgets/section_header.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/see_all_screen.dart';

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
                    HomeHeader(
                      hasNotification: hasNotification,
                      onNotificationsRead: onNotificationsRead,
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    //============================================================================
                    //! HERO SECTION
                    //============================================================================
                    const HeroSection(),

                    const SizedBox(height: AppSpacing.xl),

                    //============================================================================
                    //! SEARCH BAR
                    //============================================================================
                    HomeSearchBar(onTap: onSearchPressed),

                    const SizedBox(height: AppSpacing.xxl),

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

                    const SizedBox(height: AppSpacing.md),
                  ],
                ),
              ),

              //============================================================================
              //! BOARDING HOUSE LIST
              //============================================================================
              BhHorizontalList(boardingHouses: provider.boardingHouses),

              const SizedBox(height: AppSpacing.xxxl),
            ],
          ),
        ),
      ),
    );
  }
}
