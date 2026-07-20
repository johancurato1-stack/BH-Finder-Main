import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/view_models/room_detail_data.dart';

//============================================================================
//! ROOM META ROW
//============================================================================

class RoomMetaRow extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomMetaRow({super.key, required this.data});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final RoomDetailData data;

  //============================================================================
  //! GENDER LABEL
  //============================================================================

  String _getGenderLabel(GenderPreference gender) {
    switch (gender) {
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
        _MetaChip(
          icon: Icons.person_outline,
          label: _getGenderLabel(data.genderPreference),
        ),

        const SizedBox(width: 8),

        _MetaChip(
          icon: Icons.group_outlined,
          label: '${data.capacity} Person${data.capacity > 1 ? 's' : ''}',
        ),
      ],
    );
  }
}

//============================================================================
//! META CHIP
//============================================================================

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 3,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.tertiary),

          const SizedBox(width: 4),

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
