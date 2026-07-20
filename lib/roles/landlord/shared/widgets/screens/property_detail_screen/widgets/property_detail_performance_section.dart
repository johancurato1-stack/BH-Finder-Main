import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_performance_card.dart';

import 'package:bh_finder/shared/widgets/section_title.dart';

//============================================================================
//! PROPERTY PERFORMANCE SECTION
//============================================================================

class PropertyPerformanceSection extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyPerformanceSection({super.key});

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
          children: const [
            Expanded(
              child: PropertyDetailPerformanceCard(
                icon: Icons.meeting_room_rounded,
                label: 'Rooms',
                value: '12',
              ),
            ),

            SizedBox(width: AppSpacing.md),

            Expanded(
              child: PropertyDetailPerformanceCard(
                icon: Icons.visibility_rounded,
                label: 'Views',
                value: '1,243',
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        //====================================================================
        //! SECOND ROW
        //====================================================================
        Row(
          children: const [
            Expanded(
              child: PropertyDetailPerformanceCard(
                icon: Icons.favorite_rounded,
                label: 'Favorites',
                value: '83',
              ),
            ),

            SizedBox(width: AppSpacing.md),

            Expanded(
              child: PropertyDetailPerformanceCard(
                icon: Icons.chat_bubble_rounded,
                label: 'Inquiries',
                value: '17',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
