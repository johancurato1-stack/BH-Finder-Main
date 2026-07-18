import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/room_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class RoomMetaRow extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomMetaRow({super.key, required this.room});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final RoomModel room;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _MetaChip(icon: Icons.person_outline, label: room.genderRules),

        const SizedBox(width: 8),

        _MetaChip(icon: Icons.group_outlined, label: room.capacity),
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
        color: AppColors.white,
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
            style: const TextStyle(fontSize: 11, color: AppColors.tertiary),
          ),
        ],
      ),
    );
  }
}
