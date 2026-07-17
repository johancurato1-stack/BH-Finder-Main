import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/features/saved/shared/widgets/saved_screen_header.dart';
import 'package:bh_finder/roles/tenant/features/saved/shared/widgets/saved_screen_list.dart';

class SavedScreen extends StatelessWidget {
  final VoidCallback onBackPressed;

  const SavedScreen({super.key, required this.onBackPressed});

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
            SavedScreenHeader(onBackPressed: onBackPressed),

            //============================================================================
            //! SAVED LIST
            //============================================================================
            const Expanded(child: SavedScreenList()),
          ],
        ),
      ),
    );
  }
}
