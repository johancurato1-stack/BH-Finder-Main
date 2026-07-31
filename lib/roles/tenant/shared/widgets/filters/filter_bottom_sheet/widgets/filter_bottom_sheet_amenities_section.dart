import 'package:flutter/material.dart';

import 'package:bh_finder/roles/tenant/features/search/data/search_filter_options.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_buttons/filter_button.dart';

class FilterBottomSheetAmenitiesSection extends StatelessWidget {
  final List<String> selectedAmenities;
  final ValueChanged<String> onAmenityToggle;

  const FilterBottomSheetAmenitiesSection({
    super.key,
    required this.selectedAmenities,
    required this.onAmenityToggle,
  });

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: SearchFilterOptions.amenities.map((amenity) {
        final label = amenity['label'] as String;
        final value = amenity['value'] as String;
        final icon = amenity['icon'] as IconData;

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
