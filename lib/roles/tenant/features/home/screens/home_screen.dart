import 'package:bh_finder/core/favorites/respositories/favorite_repository.dart';
import 'package:flutter/material.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_property_horizontal_list.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_header.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_hero_section.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_search_bar.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_section_header.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/see_all_screen/see_all_screen.dart';

//============================================================================
//! HOME SCREEN
//============================================================================

class HomeScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const HomeScreen({
    super.key,
    required this.onSearchPressed,
    required this.hasNotification,
    required this.onNotificationsRead,
    required this.propertyRepository,
    required this.roomRepository,
    required this.favoriteRepository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onSearchPressed;

  final bool hasNotification;

  final VoidCallback onNotificationsRead;

  final PropertyRepository propertyRepository;

  final RoomRepository roomRepository;

  final FavoriteRepository favoriteRepository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _HomeScreenState extends State<HomeScreen> {
  //============================================================================
  //! STATE
  //============================================================================

  List<TenantPropertyCardData> _properties = [];

  bool _loading = true;

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _loadProperties();
  }

  //============================================================================
  //! LOAD PROPERTIES
  //============================================================================

  Future<void> _loadProperties() async {
    final properties = await widget.propertyRepository.getPropertyCards();

    if (!mounted) return;

    setState(() {
      _properties = properties;

      _loading = false;
    });
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.background,

        body: Center(child: CircularProgressIndicator()),
      );
    }

    final properties = _properties;

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
                      hasNotification: widget.hasNotification,

                      onNotificationsRead: widget.onNotificationsRead,
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
                    HomeScreenSearchBar(onTap: widget.onSearchPressed),

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
                              repository: widget.propertyRepository,
                              roomRepository: widget.roomRepository,
                              favoriteRepository: widget.favoriteRepository,
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
              HomeScreenPropertyHorizontalList(
                properties: properties,
                repository: widget.propertyRepository,
                roomRepository: widget.roomRepository,
                favoriteRepository: widget.favoriteRepository,
              ),

              const SizedBox(height: AppSpacing.xxxl),
            ],
          ),
        ),
      ),
    );
  }
}
