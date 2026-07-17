import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/landlord/features/properties/widgets/properties_header.dart';
import 'package:bh_finder/roles/landlord/features/properties/widgets/properties_list.dart';

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
            PropertiesHeader(onBackPressed: onBackPressed),

            const Expanded(child: PropertiesList()),
          ],
        ),
      ),
    );
  }
}
