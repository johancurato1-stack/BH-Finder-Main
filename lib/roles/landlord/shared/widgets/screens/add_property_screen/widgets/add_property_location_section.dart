import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/shared/widgets/location/location_selector.dart';
import 'package:bh_finder/shared/widgets/location/current_location_card.dart';
import 'package:bh_finder/shared/widgets/location/manual_location_form.dart';

//============================================================================
//! ADD PROPERTY LOCATION SECTION
//============================================================================

class AddPropertyLocationSection extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================
  const AddPropertyLocationSection({
    super.key,
    required this.locationOption,
    required this.onOptionChanged,

    required this.isGpsLoading,
    required this.isGpsSelected,
    required this.isGpsLocked,
    required this.isManualLoading,
    required this.isManualSelected,
    required this.isManualLocked,

    required this.detectedAddress,
    required this.onDetectLocation,
    required this.onCancelDetection,
    required this.onRemoveLocation,

    required this.provinceController,
    required this.cityController,
    required this.barangayController,
    required this.streetController,
    required this.landmarkController,
    required this.onSaveManualLocation,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  /// Currently selected location entry method (GPS or manual).
  final LocationOption? locationOption;

  /// Called when the user switches between GPS / manual entry.
  final ValueChanged<LocationOption?> onOptionChanged;

  final bool isGpsLoading;
  final bool isGpsSelected;
  final bool isGpsLocked;

  final bool isManualLoading;
  final bool isManualSelected;
  final bool isManualLocked;

  final String? detectedAddress;

  final VoidCallback onDetectLocation;
  final VoidCallback onCancelDetection;
  final VoidCallback onRemoveLocation;

  final TextEditingController provinceController;
  final TextEditingController cityController;
  final TextEditingController barangayController;
  final TextEditingController streetController;
  final TextEditingController landmarkController;

  final VoidCallback onSaveManualLocation;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final lockedOption = isGpsLoading || isGpsSelected
        ? LocationOption.manual
        : isManualLoading || isManualSelected
        ? LocationOption.gps
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LocationSelector(
          selectedOption: locationOption,
          lockedOption: lockedOption,
          onChanged: onOptionChanged,
        ),

        const SizedBox(height: AppSpacing.lg),

        if (locationOption == LocationOption.gps)
          CurrentLocationCard(
            address: detectedAddress,
            onCancelDetection: onCancelDetection,
            isLocked: isGpsLocked,
            isSelected: isGpsSelected,
            isLoading: isGpsLoading,
            onDetectLocation: onDetectLocation,
            onRemoveLocation: onRemoveLocation,
          ),

        if (locationOption == LocationOption.manual)
          ManualLocationForm(
            provinceController: provinceController,
            cityController: cityController,
            barangayController: barangayController,
            streetController: streetController,
            landmarkController: landmarkController,

            isLocked: isManualLocked,

            buttonText: isManualSelected ? 'Remove Location' : 'Save Location',

            buttonColor: isManualSelected ? Colors.red : AppColors.primary,

            onButtonPressed: isManualSelected
                ? onRemoveLocation
                : onSaveManualLocation,
          ),
      ],
    );
  }
}
