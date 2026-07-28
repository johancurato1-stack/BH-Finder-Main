import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/mock/user/mock_user.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/landlord_property_card_data.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/widgets/dashboard_screen_greeting_section.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/widgets/dashboard_screen_header.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/widgets/dashboard_screen_recent_inquiries_section.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/widgets/property_card_carousel.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/add_property_screen.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/property_detail_screen.dart';

import 'package:bh_finder/shared/widgets/others/page_indicator.dart';

//============================================================================
//! DASHBOARD SCREEN
//============================================================================

class DashboardScreen extends StatefulWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _DashboardScreenState extends State<DashboardScreen> {
  //==========================================================================
  //! REPOSITORY
  //==========================================================================

  final PropertyRepository _propertyRepository =
      Repositories.instance.propertyRepository;

  //==========================================================================
  //! VARIABLES
  //==========================================================================

  int _currentPage = 0;

  bool _loading = true;

  List<LandlordPropertyCardData> _properties = [];

  //==========================================================================
  //! LIFECYCLE
  //==========================================================================

  @override
  void initState() {
    super.initState();

    _loadProperties();
  }

  //==========================================================================
  //! LOAD PROPERTIES
  //==========================================================================

  Future<void> _loadProperties() async {
    final properties = await _propertyRepository.getLandlordPropertyCards();

    if (!mounted) return;

    setState(() {
      _properties = properties;
      _loading = false;
    });
  }

  //==========================================================================
  //! BUILD
  //==========================================================================

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
            children: [
              //==============================================================
              //! HEADER
              //==============================================================
              DashboardScreenHeader(onNotificationPressed: () {}),

              //==============================================================
              //! GREETING
              //==============================================================
              DashboardScreenGreetingSection(user: mockUser),

              const SizedBox(height: 20),

              //==============================================================
              //! PROPERTY CAROUSEL
              //==============================================================
              PropertyCardCarousel(
                properties: properties,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                onPropertyTap: (property) async {
                  final updated = await Navigator.push<bool>(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                          PropertyDetailScreen(propertyId: property.id),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0, 1);
                            const end = Offset.zero;
                            const curve = Curves.easeOut;

                            final offsetAnimation = animation.drive(
                              Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve)),
                            );

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                    ),
                  );

                  if (!mounted || updated != true) return;

                  setState(() {
                    _loading = true;
                  });

                  await _loadProperties();
                },
                onAddProperty: () async {
                  final created = await Navigator.push<bool>(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const AddPropertyScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0, 1);
                            const end = Offset.zero;
                            const curve = Curves.easeOut;

                            final offsetAnimation = animation.drive(
                              Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve)),
                            );

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                    ),
                  );

                  if (!mounted || created != true) return;

                  setState(() {
                    _loading = true;
                  });

                  await _loadProperties();
                },
              ),

              //==============================================================
              //! PAGE INDICATOR
              //==============================================================
              PageIndicator(
                currentPage: _currentPage,
                pageCount: properties.length + 1,
              ),

              //==============================================================
              //! RECENT INQUIRIES
              //==============================================================
              const DashboardScreenRecentInquiriesSection(),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
