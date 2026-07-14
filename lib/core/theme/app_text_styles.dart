import 'package:flutter/material.dart';
import 'app_colors.dart';

/// ============================================================================
/// APP TEXT STYLES
/// ----------------------------------------------------------------------------
/// Centralized typography for the entire application.
///
/// Why?
/// - Keeps every screen visually consistent.
/// - Makes future redesigns much easier.
/// - Prevents duplicated TextStyle code.
/// - Allows changing typography from one place.
///
/// Usage:
///
/// Text(
///   'Welcome',
///   style: AppTextStyles.heading1,
/// )
///
/// ============================================================================
class AppTextStyles {
  AppTextStyles._();

  //==========================================================================
  //! DISPLAY TEXT
  //==========================================================================

  /// Large hero headings.
  static const TextStyle display = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    fontFamily: 'Roboto',
    color: AppColors.secondary,
    height: 1.2,
  );

  //==========================================================================
  //! HEADINGS
  //==========================================================================

  /// Main page titles.
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    color: AppColors.secondary,
  );

  /// Section titles.
  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: 'Roboto',
    color: AppColors.secondary,
  );

  /// Small section titles.
  static const TextStyle heading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: 'Roboto',
    color: AppColors.secondary,
  );

  //==========================================================================
  //! SUBTITLES
  //==========================================================================

  /// Subtitle under headings.
  static const TextStyle subtitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    color: AppColors.tertiary,
  );

  //==========================================================================
  //! BODY TEXT
  //==========================================================================

  /// Standard body text.
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    color: AppColors.secondary,
  );

  /// Medium emphasis body text.
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    color: AppColors.secondary,
  );

  /// Bold body text.
  static const TextStyle bodyBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    color: AppColors.secondary,
  );

  //==========================================================================
  //! LABELS
  //==========================================================================

  /// Labels above text fields.
  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    color: AppColors.secondary,
  );

  /// Small helper text.
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    color: AppColors.tertiary,
  );

  /// Extra small labels.
  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    color: AppColors.tertiary,
  );

  //==========================================================================
  //! BUTTONS
  //==========================================================================

  /// Primary button text.
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Roboto',
    color: Colors.white,
  );

  /// Secondary button text.
  static const TextStyle secondaryButton = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    color: AppColors.secondary,
  );

  //==========================================================================
  //! PRICE
  //==========================================================================

  /// Used for room prices.
  static const TextStyle price = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    color: AppColors.primary,
  );
}
