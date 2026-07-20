import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/cards/add_property_card/widgets/add_property_card_icon.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/cards/add_property_card/widgets/add_property_card_text.dart';

class AddPropertyCard extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const AddPropertyCard({super.key, required this.onTap});

  //==========================================================================
  //! CALLBACK
  //==========================================================================

  final VoidCallback onTap;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //==============================================================
              //! ADD ICON
              //==============================================================
              AddPropertyCardIcon(),

              SizedBox(height: AppSpacing.lg),

              //==============================================================
              //! TEXT
              //==============================================================
              AddPropertyCardText(),
            ],
          ),
        ),
      ),
    );
  }
}
