import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/screens/properties_screen_header.dart';
import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/screens/properties_screen_list_view.dart';

class PropertiesScreen extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertiesScreen({super.key, required this.onBackPressed});

  //==========================================================================
  //! VARIABLES
  //==========================================================================

  final VoidCallback onBackPressed;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            PropertiesScreenHeader(onBackPressed: onBackPressed),

            const Expanded(child: PropertiesScreenListView()),
          ],
        ),
      ),
    );
  }
}
