import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/features/saved/widgets/saved_header.dart';
import 'package:bh_finder/features/saved/widgets/saved_list.dart';

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
            SavedHeader(onBackPressed: onBackPressed),

            //============================================================================
            //! SAVED LIST
            //============================================================================
            const Expanded(child: SavedList()),
          ],
        ),
      ),
    );
  }
}
