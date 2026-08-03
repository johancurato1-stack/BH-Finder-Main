import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/animations/animated_entrance.dart';

//============================================================================
//! EMPTY SEARCH RESULTS SCREEN
//============================================================================

class EmptySearchResultsScreen extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const EmptySearchResultsScreen({super.key});

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
                Icons.search_off_rounded,
                size: 54,
                color: AppColors.tertiary,
              ),

              SizedBox(height: 20),

              //==============================================================
              //! TITLE
              //==============================================================
              Text(
                'No Boarding Houses Found',
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
                'Try adjusting your filters or search in another location.',
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
