import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

class MenuListTile extends StatelessWidget {
  //============================================================================
  //! VARIABLES
  //============================================================================

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  final Color? iconColor;
  final Color? iconBgColor;
  final Color textColor;

  final bool hideArrow;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const MenuListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.iconColor,
    this.iconBgColor,
    this.textColor = Colors.black87,
    this.hideArrow = false,
  });

  //============================================================================
  //! GETTERS
  //============================================================================

  Color get _effectiveIconColor => iconColor ?? AppColors.primary;

  Color get _effectiveBackgroundColor =>
      iconBgColor ?? _effectiveIconColor.withValues(alpha: .10);

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        dense: true,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: 3,
        ),

        //========================================================================
        //! LEADING ICON
        //========================================================================
        leading: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),

          decoration: BoxDecoration(
            color: _effectiveBackgroundColor,
            shape: BoxShape.circle,
          ),

          child: Icon(icon, size: 25, color: _effectiveIconColor),
        ),

        //========================================================================
        //! TITLE
        //========================================================================
        title: Text(
          title,
          style: AppTextStyles.bodyBold.copyWith(
            color: textColor,
            fontSize: 15,
          ),
        ),

        //========================================================================
        //! SUBTITLE
        //========================================================================
        subtitle: subtitle == null
            ? null
            : Text(
                subtitle!,
                style: AppTextStyles.caption.copyWith(fontSize: 13),
              ),

        //========================================================================
        //! TRAILING
        //========================================================================
        trailing: hideArrow
            ? null
            : const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
                size: 18,
              ),
      ),
    );
  }
}
