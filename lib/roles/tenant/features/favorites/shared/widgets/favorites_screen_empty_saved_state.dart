import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/animations/animated_entrance.dart';

//============================================================================
//! FAVORITES SCREEN EMPTY SAVED STATE
//============================================================================

class FavoritesScreenEmptySavedState extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const FavoritesScreenEmptySavedState({super.key});

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
                Icons.favorite_border_rounded,
                size: 54,
                color: AppColors.tertiary,
              ),

              SizedBox(height: 20),

              //==============================================================
              //! TITLE
              //==============================================================
              Text(
                'No Saved Properties',
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
                'Save properties you like to quickly find them here.',
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
