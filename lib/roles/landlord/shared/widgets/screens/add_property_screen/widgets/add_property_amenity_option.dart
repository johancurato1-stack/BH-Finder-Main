import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';

//============================================================================
//! AMENITY OPTION
//============================================================================

class AddPropertyAmenityOption {
  const AddPropertyAmenityOption({
    required this.type,
    required this.label,
    required this.icon,
  });

  final Amenity type;

  final String label;

  final IconData icon;
}
