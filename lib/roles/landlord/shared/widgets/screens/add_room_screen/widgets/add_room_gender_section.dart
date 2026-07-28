import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/shared/widgets/others/section_title.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_buttons/filter_button.dart';

//============================================================================
//! ADD ROOM GENDER SECTION
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

  final GenderPreference selectedGender;

  final ValueChanged<GenderPreference> onGenderChanged;

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
              isSelected: selectedGender == GenderPreference.male,
              onTap: () => onGenderChanged(GenderPreference.male),
            ),
            FilterButton(
              label: 'Female',
              isSelected: selectedGender == GenderPreference.female,
              onTap: () => onGenderChanged(GenderPreference.female),
            ),
          ],
        ),
      ],
    );
  }
}
