import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/others/section_title.dart';

//============================================================================
//! ROOM DESCRIPTION SECTION
//============================================================================

class RoomDetailDescriptionSection extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomDetailDescriptionSection({super.key, required this.description});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String description;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //==========================================================================
        //! TITLE
        //==========================================================================
        const SectionTitle(title: 'Description'),

        const SizedBox(height: 8),

        //==========================================================================
        //! DESCRIPTION
        //==========================================================================
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.secondary,
            fontFamily: 'Roboto',
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
