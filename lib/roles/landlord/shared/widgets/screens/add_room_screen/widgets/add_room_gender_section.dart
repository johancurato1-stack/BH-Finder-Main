import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/shared/widgets/others/section_title.dart';
import 'package:bh_finder/shared/widgets/form/gender_preference_selector.dart';

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

  final GenderPreference? selectedGender;

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

        const SizedBox(height: 20),

        //==============================================================
        //! GENDER SELECTOR
        //==============================================================
        GenderPreferenceSelector(
          value: selectedGender,
          onChanged: onGenderChanged,
        ),
      ],
    );
  }
}
