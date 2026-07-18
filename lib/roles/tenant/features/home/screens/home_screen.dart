import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/property_repository.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/view_models/property_card_data.dart';

import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_property_horizontal_list.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_header.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_hero_section.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_search_bar.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_section_header.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/see_all_screen/see_all_screen.dart';

//============================================================================
//! HOME SCREEN
//============================================================================

class HomeScreen extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const HomeScreen({
    super.key,
    required this.onSearchPressed,
    required this.hasNotification,
    required this.onNotificationsRead,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onSearchPressed;

  final bool hasNotification;

  final VoidCallback onNotificationsRead;

  //============================================================================
  //! DEPENDENCIES
  //============================================================================

  static final PropertyRepository _propertyRepository = PropertyRepository();

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final List<PropertyCardData> properties = _propertyRepository
        .getPropertyCards();

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

                    //==========================================================
                    //! HOME HEADER
                    //==========================================================
                    HomeScreenHeader(
                      hasNotification: hasNotification,
                      onNotificationsRead: onNotificationsRead,
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    //==========================================================
                    //! HERO SECTION
                    //==========================================================
                    const HomeScreenHeroSection(),

                    const SizedBox(height: AppSpacing.xl),

                    //==========================================================
                    //! SEARCH BAR
                    //==========================================================
                    HomeScreenSearchBar(onTap: onSearchPressed),

                    const SizedBox(height: AppSpacing.xxl),

                    //==========================================================
                    //! NEAR YOU
                    //==========================================================
                    HomeScreenSectionHeader(
                      title: 'Near You',
                      onSeeAll: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SeeAllScreen(
                              title: 'Near You',
                              properties: properties,
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

              //==============================================================
              //! PROPERTY LIST
              //==============================================================
              HomeScreenPropertyHorizontalList(properties: properties),

              const SizedBox(height: AppSpacing.xxxl),
            ],
          ),
        ),
      ),
    );
  }
}
