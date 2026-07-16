import 'package:flutter/material.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/filter_button.dart';

class AmenitiesGrid extends StatelessWidget {
  final List<Map<String, dynamic>> amenities;
  final List<String> selectedAmenities;
  final ValueChanged<String> onToggle;

  const AmenitiesGrid({
    super.key,
    required this.amenities,
    required this.selectedAmenities,
    required this.onToggle,
  });

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,

      children: amenities.map((amenity) {
        final label = amenity['label'] as String;
        final icon = amenity['icon'] as IconData;

        return FilterButton(
          label: label,
          icon: icon,
          isSelected: selectedAmenities.contains(label),
          onTap: () => onToggle(label),
        );
      }).toList(),
    );
  }
}
