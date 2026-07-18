import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class PropertyMetaRow extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyMetaRow({super.key, required this.boardingHouse});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final BoardingHouseModel boardingHouse;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _MetaChip(icon: Icons.person_outline, label: boardingHouse.genderRules),

        const SizedBox(width: 8),

        _MetaChip(
          icon: Icons.meeting_room,
          label: '${boardingHouse.totalRooms} Rooms',
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
