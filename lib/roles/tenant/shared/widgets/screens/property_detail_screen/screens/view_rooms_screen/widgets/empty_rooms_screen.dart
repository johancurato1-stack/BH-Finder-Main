import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/animations/animated_entrance.dart';

//============================================================================
//! EMPTY ROOMS SCREEN
//============================================================================

class EmptyRoomsScreen extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const EmptyRoomsScreen({super.key});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return const AnimatedEntrance(
      order: 0,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //==============================================================
              //! ICON
              //==============================================================
              Icon(
                Icons.meeting_room_outlined,
                size: 54,
                color: AppColors.tertiary,
              ),

              SizedBox(height: 20),

              //==============================================================
              //! TITLE
              //==============================================================
              Text(
                'No Rooms Available',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                  color: AppColors.secondary,
                ),
              ),

              SizedBox(height: 10),

              //==============================================================
              //! SUBTITLE
              //==============================================================
              Text(
                'The landlord hasn\'t listed any rooms yet.\nPlease check back later.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  fontFamily: 'Roboto',
                  color: AppColors.tertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
