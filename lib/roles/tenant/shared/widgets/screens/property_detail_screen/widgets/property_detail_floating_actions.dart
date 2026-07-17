import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/core/providers/boarding_house_provider.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class PropertyFloatingActions extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyFloatingActions({
    super.key,
    required this.boardingHouse,
    required this.onBack,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final BoardingHouseModel boardingHouse;
  final VoidCallback onBack;

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

          Consumer<BoardingHouseProvider>(
            builder: (context, provider, child) {
              return Row(
                children: [
                  _FloatingButton(
                    icon: boardingHouse.isSaved
                        ? Icons.favorite
                        : Icons.favorite_border,
                    iconColor: boardingHouse.isSaved
                        ? Colors.red
                        : AppColors.secondary,
                    onTap: () => provider.toggleSaved(boardingHouse),
                  ),

                  const SizedBox(width: 12),

                  _FloatingButton(
                    icon: Icons.share,
                    iconColor: AppColors.secondary,
                    onTap: () {},
                  ),
                ],
              );
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
