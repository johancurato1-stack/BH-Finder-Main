import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/ui_models/property_detail_data.dart';

//============================================================================
//! PROPERTY DETAIL META ROW
//============================================================================

class PropertyDetailMetaRow extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyDetailMetaRow({super.key, required this.data});

  //============================================================================
  //! VARIABLES
  //============================================================================

  final PropertyDetailData data;

  //============================================================================
  //! GENDER LABEL
  //============================================================================

  String get _genderLabel {
    switch (data.genderPreference) {
      case GenderPreference.male:
        return 'Male';

      case GenderPreference.female:
        return 'Female';

      case GenderPreference.mixed:
        return 'Mixed';
    }
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //==============================================================
        //! GENDER
        //==============================================================
        _MetaChip(icon: Icons.person_outline_rounded, label: _genderLabel),

        const SizedBox(width: 8),

        //==============================================================
        //! ROOM COUNT
        //==============================================================
        _MetaChip(
          icon: Icons.meeting_room_rounded,
          label: '${data.roomCount} ${data.roomCount == 1 ? 'Room' : 'Rooms'}',
        ),
      ],
    );
  }
}

//============================================================================
//! META CHIP
//============================================================================

class _MetaChip extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const _MetaChip({required this.icon, required this.label});

  //============================================================================
  //! VARIABLES
  //============================================================================

  final IconData icon;

  final String label;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(8),

        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .10),
            blurRadius: 3,
          ),
        ],
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          //============================================================
          //! ICON
          //============================================================
          Icon(icon, size: 14, color: AppColors.tertiary),

          const SizedBox(width: 4),

          //============================================================
          //! LABEL
          //============================================================
          Text(
            label,

            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
              color: AppColors.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
