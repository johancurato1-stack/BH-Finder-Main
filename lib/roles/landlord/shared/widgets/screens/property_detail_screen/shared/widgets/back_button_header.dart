import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! BACK BUTTON HEADER
//============================================================================

class BackButtonHeader extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const BackButtonHeader({
    super.key,
    required this.onBackPressed,
    this.onSharePressed,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onBackPressed;

  final VoidCallback? onSharePressed;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onBackPressed,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          splashRadius: 24,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.secondary,
            size: 24,
          ),
        ),

        const Spacer(),

        if (onSharePressed != null)
          IconButton(
            onPressed: onSharePressed,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 24,
            icon: const Icon(
              Icons.share_outlined,
              color: AppColors.secondary,
              size: 24,
            ),
          ),
      ],
    );
  }
}
