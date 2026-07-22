import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! PROPERTY FLOATING ACTIONS
//============================================================================

class PropertyDetailFloatingActions extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyDetailFloatingActions({
    super.key,
    required this.onBack,
    required this.onFavorite,
    required this.isFavorite,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onBack;
  final VoidCallback onFavorite;
  final bool isFavorite;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 12,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _FloatingButton(
            icon: Icons.arrow_back_ios_new_rounded,
            iconColor: AppColors.secondary,
            onTap: onBack,
          ),

          const Spacer(),

          _FloatingButton(
            icon: isFavorite ? Icons.favorite : Icons.favorite_border,
            iconColor: isFavorite ? Colors.red : AppColors.secondary,
            onTap: onFavorite,
          ),

          const SizedBox(width: 12),

          _FloatingButton(
            icon: Icons.share,
            iconColor: AppColors.secondary,
            onTap: () {
              // TODO: Share property.
            },
          ),
        ],
      ),
    );
  }
}

//============================================================================
//! FLOATING BUTTON
//============================================================================

class _FloatingButton extends StatelessWidget {
  const _FloatingButton({
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  final IconData icon;

  final VoidCallback onTap;

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: AppColors.background,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: iconColor ?? AppColors.secondary),
      ),
    );
  }
}
