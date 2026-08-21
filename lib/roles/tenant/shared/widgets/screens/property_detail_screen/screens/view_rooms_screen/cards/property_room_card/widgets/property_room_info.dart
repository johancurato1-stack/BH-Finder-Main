import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/models/room_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! PROPERTY ROOM INFO
//============================================================================

class PropertyRoomInfo extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyRoomInfo({super.key, required this.room});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final RoomModel room;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //======================================================================
        //! ROOM NUMBER
        //======================================================================
        Text(
          room.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        //======================================================================
        //! PRICE
        //======================================================================
        Text(
          '₱ ${room.price} / month',
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 13),

        //======================================================================
        //! DETAILS
        //======================================================================
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.person_outline,
              size: 15,
              color: AppColors.tertiary,
            ),

            const SizedBox(width: 6),

            Text(
              _getGenderLabel(room.genderPreference),
              style: const TextStyle(fontSize: 10, color: AppColors.tertiary),
            ),

            const SizedBox(width: 10),

            const Icon(
              Icons.group_outlined,
              size: 15,
              color: AppColors.tertiary,
            ),

            const SizedBox(width: 6),

            Text(
              '${room.capacity} Person${room.capacity > 1 ? 's' : ''}',
              style: const TextStyle(fontSize: 10, color: AppColors.tertiary),
            ),
          ],
        ),
      ],
    );
  }
}
