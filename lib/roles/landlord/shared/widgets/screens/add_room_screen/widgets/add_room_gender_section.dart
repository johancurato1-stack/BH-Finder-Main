import 'package:flutter/material.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_buttons/filter_button.dart';
import 'package:bh_finder/shared/widgets/section_title.dart';

//============================================================================
//! ADD PROPERTY GENDER SECTION
//============================================================================

class AddRoomGenderSection extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const AddRoomGenderSection({
    super.key,
    required this.selectedGender,
    required this.onGenderChanged,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String selectedGender;

  final ValueChanged<String> onGenderChanged;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //==============================================================
        //! TITLE
        //==============================================================
        const SectionTitle(title: 'Gender Preference'),

        const SizedBox(height: 16),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilterButton(
              label: 'Male',
              isSelected: selectedGender == 'Male',
              onTap: () => onGenderChanged('Male'),
            ),
            FilterButton(
              label: 'Female',
              isSelected: selectedGender == 'Female',
              onTap: () => onGenderChanged('Female'),
            ),
          ],
        ),
      ],
    );
  }
}
