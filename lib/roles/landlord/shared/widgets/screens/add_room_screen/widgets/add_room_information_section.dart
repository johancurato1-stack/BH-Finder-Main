import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/others/section_title.dart';
import 'package:bh_finder/shared/widgets/textfields/prefixed_text_field.dart';
import 'package:bh_finder/shared/widgets/textfields/primary_form_text_field.dart';

//============================================================================
//! ADD ROOM INFORMATION SECTION
//============================================================================

class AddRoomInformationSection extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const AddRoomInformationSection({
    super.key,
    required this.titleController,
    required this.priceController,
    required this.capacityController,
    required this.descriptionController,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final TextEditingController titleController;

  final TextEditingController priceController;

  final TextEditingController capacityController;

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
        const SectionTitle(title: 'Room Information'),

        const SizedBox(height: 20),

        //==============================================================
        //! ROOM TITLE
        //==============================================================
        const Text(
          'Room Title',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.secondary,
          ),
        ),

        const SizedBox(height: 8),

        PrimaryFormField(
          controller: titleController,
          hintText: 'Enter room title',
          prefixIcon: Icons.home_rounded,
        ),

        const SizedBox(height: 20),

        //==============================================================
        //! ROOM DETAILS
        //==============================================================
        const Text(
          'Room Details',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.secondary,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              child: PrefixedTextField(
                controller: priceController,
                hintText: '0',
                prefixText: '₱',
                keyboardType: TextInputType.number,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: PrefixedTextField(
                controller: capacityController,
                hintText: '0',
                prefixIcon: Icons.groups_outlined,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        //==============================================================
        //! DESCRIPTION
        //==============================================================
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.secondary,
          ),
        ),

        const SizedBox(height: 8),

        PrimaryFormField(
          controller: descriptionController,
          hintText: 'Describe your room...',
          keyboardType: TextInputType.multiline,
          maxLines: 5,
        ),
      ],
    );
  }
}
