import 'package:flutter/material.dart';

import 'package:bh_finder/core/constants/amenities.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_amenity_button.dart';
import 'package:bh_finder/shared/widgets/section_title.dart';

//============================================================================
//! ADD PROPERTY AMENITIES SECTION
//============================================================================

class AddPropertyAmenitiesSection extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const AddPropertyAmenitiesSection({
    super.key,
    required this.selectedAmenities,
    required this.onAmenityToggled,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<String> selectedAmenities;

  final ValueChanged<String> onAmenityToggled;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Amenities'),

        const SizedBox(height: 16),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: Amenities.values.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3.2,
          ),
          itemBuilder: (context, index) {
            final amenity = Amenities.values[index];

            return AmenityButton(
              icon: amenity.icon,
              label: amenity.label,
              isSelected: selectedAmenities.contains(amenity.label),
              onTap: () => onAmenityToggled(amenity.label),
            );
          },
        ),
      ],
    );
  }
}
