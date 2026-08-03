import 'package:flutter/material.dart';

//============================================================================
//! PROPERTY CARD STATUS TAG
//============================================================================

class PropertyCardStatusTag extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyCardStatusTag({
    super.key,
    required this.label,
    required this.color,
  });

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final String label;
  final Color color;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
