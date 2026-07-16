import 'package:flutter/material.dart';

/// ============================================================================
/// FILTER MODELS
/// ----------------------------------------------------------------------------
/// Models used by the search filter bottom sheet.
/// ============================================================================

//============================================================================
//! AMENITY FILTER
//============================================================================

class AmenityFilter {
  final String label;
  final IconData icon;

  const AmenityFilter({required this.label, required this.icon});
}

//============================================================================
//! STATUS FILTER
//============================================================================

class StatusFilter {
  final String label;
  final Color color;

  const StatusFilter({required this.label, required this.color});
}
