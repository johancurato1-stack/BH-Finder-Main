import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories/room_repository.dart';
import 'package:bh_finder/core/repositories/repositories/favorite_repository.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/core/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/shared/widgets/animations/animated_entrance.dart';

import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_header.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_hero_section.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_search_bar.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_section_header.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/home_screen/home_screen_property_horizontal_list.dart';

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
  //! CALLBACKS
  //============================================================================

  final VoidCallback onSearchPressed;

  final bool hasNotification;

  final VoidCallback onNotificationsRead;

  //============================================================================
  //! REPOSITORIES
  //============================================================================

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

    if (!mounted) {
      return;
    }

    setState(() {
      _properties = properties;
      _loading = false;
    });
  }

  //============================================================================
  //! OPEN SEE ALL
  //============================================================================

  void _openSeeAll() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => SeeAllScreen(
          title: 'Near You',
          repository: widget.propertyRepository,
          roomRepository: widget.roomRepository,
          favoriteRepository: widget.favoriteRepository,
        ),

        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),

            child: child,
          );
        },
      ),
    );
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
                    AnimatedEntrance(
                      order: 0,
                      child: HomeScreenHeader(
                        hasNotification: widget.hasNotification,
                        onNotificationsRead: widget.onNotificationsRead,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    //==========================================================
                    //! HERO SECTION
                    //==========================================================
                    const AnimatedEntrance(
                      order: 1,
                      child: HomeScreenHeroSection(),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    //==========================================================
                    //! SEARCH BAR
                    //==========================================================
                    AnimatedEntrance(
                      order: 2,
                      child: HomeScreenSearchBar(onTap: widget.onSearchPressed),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    //==========================================================
                    //! NEAR YOU
                    //==========================================================
                    AnimatedEntrance(
                      order: 3,
                      child: HomeScreenSectionHeader(
                        title: 'Near You',
                        onSeeAll: _openSeeAll,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),
                  ],
                ),
              ),

              //==============================================================
              //! PROPERTY LIST
              //==============================================================
              AnimatedEntrance(
                order: 4,
                child: HomeScreenPropertyHorizontalList(
                  properties: _properties,
                  repository: widget.propertyRepository,
                  roomRepository: widget.roomRepository,
                  favoriteRepository: widget.favoriteRepository,
                ),
              ),

              const SizedBox(height: AppSpacing.xxxl),
            ],
          ),
        ),
      ),
    );
  }
}
