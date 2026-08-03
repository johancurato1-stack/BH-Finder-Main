import 'package:flutter/material.dart';

import 'package:bh_finder/core/options/search_filter_options.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_buttons/filter_button.dart';

//============================================================================
//! FILTER BOTTOM SHEET AMENITIES SECTION
//============================================================================

class FilterBottomSheetAmenitiesSection extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const FilterBottomSheetAmenitiesSection({
    super.key,
    required this.selectedAmenities,
    required this.onAmenityToggle,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<String> selectedAmenities;

  final ValueChanged<String> onAmenityToggle;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: SearchFilterOptions.amenities.map((amenity) {
        final String label = amenity['label'] as String;

        final String value = amenity['value'] as String;

        final IconData icon = amenity['icon'] as IconData;

        return FilterButton(
          label: label,
          icon: icon,
          isSelected: selectedAmenities.contains(value),
          onTap: () => onAmenityToggle(value),
        );
      }).toList(),
    );
  }
}
