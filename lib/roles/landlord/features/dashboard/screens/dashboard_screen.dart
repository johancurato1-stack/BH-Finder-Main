import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/property_repository.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/data/mock/user/mock_user.dart';

import 'package:bh_finder/core/view_models/landlord_property_card_data.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/widgets/dashboard_screen_header.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/widgets/dashboard_screen_greeting_section.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/property_carousel.dart';
import 'package:bh_finder/shared/page_indicator.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/widgets/dashboard_screen_recent_inquiries_section.dart';

class DashboardScreen extends StatefulWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //==========================================================================
  //! REPOSITORIES
  //==========================================================================

  static final PropertyRepository _propertyRepository = PropertyRepository();

  //==========================================================================
  //! VARIABLES
  //==========================================================================

  int _currentPage = 0;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    final List<LandlordPropertyCardData> properties = _propertyRepository
        .getLandlordPropertyCards();

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
              PropertyCarousel(
                properties: properties,

                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },

                onPropertyTap: (property) {
                  // TODO:
                  // Navigate to Manage Property Screen
                },

                onAddProperty: () {
                  // TODO:
                  // Navigate to Add Property Flow
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
