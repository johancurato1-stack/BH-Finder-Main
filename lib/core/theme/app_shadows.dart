import 'package:flutter/material.dart';

/// ============================================================================
/// APP SHADOWS
/// ----------------------------------------------------------------------------
/// Centralized shadows used throughout the application.
///
/// Why?
/// - Keeps elevation consistent.
/// - Removes duplicated BoxShadow code.
/// - Makes UI updates much easier.
/// ============================================================================

class AppShadows {
  AppShadows._();

  //==========================================================================
  //! CARD SHADOW
  //==========================================================================

  static const List<BoxShadow> card = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2)),
  ];

  //==========================================================================
  //! ELEVATED SHADOW
  //==========================================================================

  static const List<BoxShadow> elevated = [
    BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 4)),
  ];

  //==========================================================================
  //! LIGHT SHADOW
  //==========================================================================

  static const List<BoxShadow> light = [
    BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 1)),
  ];
}
