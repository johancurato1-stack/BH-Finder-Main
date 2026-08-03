import 'package:flutter/material.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_buttons/filter_button.dart';

//============================================================================
//! SEARCH SCREEN AMENITIES GRID
//============================================================================

class SearchScreenAmenitiesGrid extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SearchScreenAmenitiesGrid({
    super.key,
    required this.amenities,
    required this.selectedAmenities,
    required this.onToggle,
  });

  //============================================================================
  //! VARIABLES
  //============================================================================

  final List<Map<String, dynamic>> amenities;

  final List<String> selectedAmenities;

  final ValueChanged<String> onToggle;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,

      children: List.generate(amenities.length, (index) {
        final item = amenities[index];

        final label = item['label'] as String;
        final value = item['value'] as String;
        final icon = item['icon'] as IconData;

        return FilterButton(
          label: label,
          icon: icon,
          isSelected: selectedAmenities.contains(value),
          onTap: () => onToggle(value),
        );
      }),
    );
  }
}
