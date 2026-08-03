import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/cards/add_property_card_horizontal/widgets/add_property_card_horizontal_icon.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/cards/add_property_card_horizontal/widgets/add_property_card_horizontal_text.dart';

//============================================================================
//! ADD PROPERTY CARD HORIZONTAL
//============================================================================

class AddPropertyCardHorizontal extends StatefulWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const AddPropertyCardHorizontal({super.key, required this.onTap});

  //==========================================================================
  //! CALLBACK
  //==========================================================================

  final VoidCallback onTap;

  @override
  State<AddPropertyCardHorizontal> createState() =>
      _AddPropertyCardHorizontalState();
}

//============================================================================
//! STATE
//============================================================================

class _AddPropertyCardHorizontalState extends State<AddPropertyCardHorizontal> {
  //==========================================================================
  //! STATE
  //==========================================================================

  bool _pressed = false;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOutCubic,
      scale: _pressed ? .97 : 1,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),

          splashColor: AppColors.primary.withValues(alpha: .08),

          highlightColor: Colors.transparent,

          onTapDown: (_) {
            setState(() {
              _pressed = true;
            });
          },

          onTapCancel: () {
            setState(() {
              _pressed = false;
            });
          },

          onTap: () {
            setState(() {
              _pressed = false;
            });

            widget.onTap();
          },

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),

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
                  //==========================================================
                  //! ADD ICON
                  //==========================================================
                  AddPropertyCardHorizontalIcon(),

                  SizedBox(height: AppSpacing.lg),

                  //==========================================================
                  //! TEXT
                  //==========================================================
                  AddPropertyCardHorizontalText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
