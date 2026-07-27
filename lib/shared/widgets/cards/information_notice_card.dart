import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

class InformationNoticeCard extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const InformationNoticeCard({
    super.key,
    required this.message,
    this.icon = Icons.info_rounded,
    this.iconColor = const Color(0xFF4B4B9A),
    this.backgroundColor = const Color(0xFFEBEBFA),
    this.borderColor = const Color(0xFFD1D1E9),
    this.textColor = const Color(0xFF4B4B9A),
    this.margin = const EdgeInsets.all(AppSpacing.lg),
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String message;

  final IconData icon;

  final Color iconColor;

  final Color backgroundColor;

  final Color borderColor;

  final Color textColor;

  final EdgeInsetsGeometry margin;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: borderColor, width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: iconColor),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontSize: 13,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
