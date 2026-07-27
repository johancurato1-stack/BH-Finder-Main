import 'package:flutter/material.dart';

import 'package:bh_finder/shared/widgets/textfields/primary_form_text_field.dart';
import 'package:bh_finder/shared/widgets/others/section_title.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! ADD PROPERTY INFORMATION SECTION
//============================================================================

class AddPropertyInformationSection extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const AddPropertyInformationSection({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final TextEditingController titleController;

  final TextEditingController descriptionController;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //==============================================================
        //! SECTION TITLE
        //==============================================================
        const SectionTitle(title: 'Property Information'),

        const SizedBox(height: 20),

        //==============================================================
        //! PROPERTY TITLE
        //==============================================================
        const Text(
          'Property Title',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.secondary,
          ),
        ),

        const SizedBox(height: 8),

        PrimaryFormField(
          controller: titleController,
          hintText: 'Enter property title',
          prefixIcon: Icons.home_rounded,
        ),

        const SizedBox(height: 20),

        //==============================================================
        //! DESCRIPTION
        //==============================================================
        const Text(
          'Description (Optional)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.secondary,
          ),
        ),

        const SizedBox(height: 8),

        PrimaryFormField(
          controller: descriptionController,
          hintText: 'Describe your property...',
          keyboardType: TextInputType.multiline,
          maxLines: 5,
        ),
      ],
    );
  }
}
