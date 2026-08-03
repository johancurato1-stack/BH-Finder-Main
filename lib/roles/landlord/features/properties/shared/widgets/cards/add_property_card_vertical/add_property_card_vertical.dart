import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

//============================================================================
//! ADD PROPERTY CARD VERTICAL
//============================================================================

class AddPropertyCardVertical extends StatefulWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const AddPropertyCardVertical({super.key, this.onTap});

  //==========================================================================
  //! CALLBACK
  //==========================================================================

  final VoidCallback? onTap;

  @override
  State<AddPropertyCardVertical> createState() =>
      _AddPropertyCardVerticalState();
}

//============================================================================
//! STATE
//============================================================================

class _AddPropertyCardVerticalState extends State<AddPropertyCardVertical> {
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
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),

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

            widget.onTap?.call();
          },

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),

            height: 188,

            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
              vertical: AppSpacing.sm,
            ),

            decoration: BoxDecoration(
              color: AppColors.white,

              borderRadius: BorderRadius.circular(12),

              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: .10),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //==========================================================
                //! ADD ICON
                //==========================================================
                Container(
                  height: 42,
                  width: 42,

                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: .10),
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.add_rounded,
                    color: AppColors.primary,
                    size: 26,
                  ),
                ),

                const SizedBox(height: AppSpacing.sm),

                //==========================================================
                //! TITLE
                //==========================================================
                Text(
                  'Add Property',
                  style: AppTextStyles.heading3.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
