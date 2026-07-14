/// ============================================================================
/// APP SPACING
/// ----------------------------------------------------------------------------
/// Centralized spacing values used throughout the application.
///
/// Why?
/// - Removes magic numbers.
/// - Keeps spacing consistent.
/// - Makes redesigns much easier.
///
/// Example:
///
/// SizedBox(height: AppSpacing.lg)
///
/// Padding(
///   padding: EdgeInsets.all(AppSpacing.screenPadding),
/// )
/// ============================================================================
class AppSpacing {
  AppSpacing._();

  //==========================================================================
  //! SPACING SCALE
  //==========================================================================

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;
  static const double massive = 60;

  //==========================================================================
  //! COMMON PADDING
  //==========================================================================

  static const double screenPadding = 20;
  static const double cardPadding = 12;
  static const double buttonHeight = 52;
  static const double inputHeight = 42;
}
