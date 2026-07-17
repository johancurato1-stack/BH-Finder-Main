import 'package:flutter/material.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_buttons/filter_button.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/constants/filter_constants.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/models/filters/filter_model.dart';

class AmenitiesSection extends StatelessWidget {
  final List<String> selectedAmenities;
  final ValueChanged<String> onAmenityToggle;

  const AmenitiesSection({
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

      children: FilterConstants.amenities.map((AmenityFilter amenity) {
        final label = amenity.label;
        final isSelected = selectedAmenities.contains(label);

        return FilterButton(
          label: label,
          icon: amenity.icon,
          isSelected: isSelected,
          onTap: () => onAmenityToggle(label),
        );
      }).toList(),
    );
  }
}
