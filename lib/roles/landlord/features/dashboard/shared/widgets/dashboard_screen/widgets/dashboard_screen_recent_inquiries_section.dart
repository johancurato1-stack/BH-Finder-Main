import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/widgets/dashboard_screen_inquiry_tile.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/data/mock_data/mock_inquires.dart';

//==========================================================================
//! DASHBOARD SCREEN RECENT INQUIRIES SECTION
//==========================================================================

class DashboardScreenRecentInquiriesSection extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const DashboardScreenRecentInquiriesSection({super.key});

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        //======================================================================
        //! HEADER
        //======================================================================
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text('Recent Inquiries', style: AppTextStyles.heading3),

              TextButton(
                onPressed: () {
                  // TODO: Navigate to Messages Screen
                },

                child: const Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        //======================================================================
        //! INQUIRIES
        //======================================================================
        ...mockInquiries.map((inquiry) {
          return DashboardScreenInquiryTile(
            name: inquiry.tenantName,
            boardingHouse: inquiry.boardingHouseName,
            time: inquiry.time,
            avatarUrl: inquiry.avatarUrl,
            onTap: () {},
          );
        }),
      ],
    );
  }
}
