import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/data/mock_data/mock_user.dart';
import 'package:bh_finder/core/data/mock_data/mock_boarding_houses.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/widgets/dashboard_header.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/widgets/greeting_section.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/widgets/boarding_house_carousel.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/widgets/page_indicator.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/widgets/recent_inquiries_section.dart';

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
              DashboardHeader(onNotificationPressed: () {}),

              //==============================================================
              //! GREETING
              //==============================================================
              GreetingSection(user: mockUser),

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
              const RecentInquiriesSection(),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
