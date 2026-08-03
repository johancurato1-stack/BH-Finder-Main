import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/ui_models/room_detail_data.dart';

//============================================================================
//! ROOM DETAIL HEADER
//============================================================================

class RoomDetailHeader extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomDetailHeader({super.key, required this.data});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final RoomDetailData data;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //======================================================================
        //! TITLE
        //======================================================================
        Text(
          data.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.secondary,
          ),
        ),

        //======================================================================
        //! PRICE
        //======================================================================
        Text(
          '₱ ${data.price} / month',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
