import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/data/mock/mock_user.dart';
import 'package:bh_finder/core/data/mock/mock_boarding_houses.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/dashboard_screen_header.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/dashboard_screen_greeting_section.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/boarding_house_carousel.dart';
import 'package:bh_finder/shared/page_indicator.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/dashboard_screen_recent_inquiries_section.dart';

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
  //! VARIABLES
  //==========================================================================

  int _currentPage = 0;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
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
              //! BOARDING HOUSE CAROUSEL
              //==============================================================
              BoardingHouseCarousel(
                boardingHouses: mockBoardingHouses,

                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },

                onPropertyTap: (boardingHouse) {
                  // TODO:
                  // Navigate to Manage Property Screen
                },

                onAddProperty: () {
                  // TODO:
                  // Navigate to Add Boarding House Flow
                },
              ),

              //==============================================================
              //! PAGE INDICATOR
              //==============================================================
              PageIndicator(
                currentPage: _currentPage,
                pageCount: mockBoardingHouses.length + 1,
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
