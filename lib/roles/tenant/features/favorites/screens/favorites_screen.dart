import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/features/favorites/shared/widgets/favorites_screen_header.dart';
import 'package:bh_finder/roles/tenant/features/favorites/shared/widgets/favorites_screen_list.dart';

class FavoritesScreen extends StatelessWidget {
  final VoidCallback onBackPressed;

  const FavoritesScreen({super.key, required this.onBackPressed});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            //============================================================================
            //! HEADER
            //============================================================================
            FavoritesScreenHeader(onBackPressed: onBackPressed),

            //============================================================================
            //! SAVED LIST
            //============================================================================
            const Expanded(child: FavoritesScreenList()),
          ],
        ),
      ),
    );
  }
}
