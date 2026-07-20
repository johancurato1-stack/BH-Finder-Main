import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/section_title.dart';

//============================================================================
//! PROPERTY DESCRIPTION SECTION
//============================================================================

class PropertyDescriptionSection extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyDescriptionSection({super.key, required this.description});

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
        //======================================================================
        //! TITLE
        //======================================================================
        const SectionTitle(title: 'About this place'),

        const SizedBox(height: 8),

        //======================================================================
        //! DESCRIPTION
        //======================================================================
        Text(
          description,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.secondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
