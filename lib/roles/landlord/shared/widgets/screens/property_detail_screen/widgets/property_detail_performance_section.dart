import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/ui_models/property_detail_data.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_performance_card.dart';

import 'package:bh_finder/shared/widgets/others/section_title.dart';

//============================================================================
//! PROPERTY PERFORMANCE SECTION
//============================================================================

class PropertyDetailPerformanceSection extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyDetailPerformanceSection({super.key, required this.data});

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final PropertyDetailData data;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //====================================================================
        //! SECTION TITLE
        //====================================================================
        const SectionTitle(title: 'Performance'),

        const SizedBox(height: AppSpacing.md),

        //====================================================================
        //! FIRST ROW
        //====================================================================
        Row(
          children: [
            Expanded(
              child: PropertyDetailPerformanceCard(
                icon: Icons.meeting_room_rounded,
                label: 'Rooms',
                value: data.roomCount.toString(),
              ),
            ),

            const SizedBox(width: AppSpacing.md),

            Expanded(
              child: PropertyDetailPerformanceCard(
                icon: Icons.visibility_rounded,
                label: 'Views',
                value: data.totalViews.toString(),
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        //====================================================================
        //! SECOND ROW
        //====================================================================
        Row(
          children: [
            Expanded(
              child: PropertyDetailPerformanceCard(
                icon: Icons.favorite_rounded,
                label: 'Favorites',
                value: data.favoriteCount.toString(),
              ),
            ),

            const SizedBox(width: AppSpacing.md),

            Expanded(
              child: PropertyDetailPerformanceCard(
                icon: Icons.chat_bubble_rounded,
                label: 'Inquiries',
                value: data.totalInquiries.toString(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
