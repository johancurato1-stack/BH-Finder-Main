import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/shared/widgets/back_button_header.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_photos_section.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_information_section.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_amenities_section.dart';
import 'package:bh_finder/shared/widgets/location/location_selector.dart';
import 'package:bh_finder/shared/widgets/location/current_location_card.dart';
import 'package:bh_finder/shared/widgets/location/manual_location_form.dart';
import 'package:bh_finder/shared/widgets/cards/information_notice_card.dart';
import 'package:bh_finder/shared/widgets/dialogs/primary_dialog.dart';

import 'package:bh_finder/shared/widgets/services/location_service.dart';

//============================================================================
//! LOCATION STATUS
//============================================================================

enum LocationStatus {
  none,

  gpsDetecting,
  gpsSelected,

  manualSaving,
  manualSelected,
}

//============================================================================
//! ADD PROPERTY SCREEN
//============================================================================

class AddPropertyScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  //============================================================================
  //! CONTROLLERS
  //============================================================================

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _provinceController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _barangayController = TextEditingController();

  final TextEditingController _streetController = TextEditingController();

  final TextEditingController _landmarkController = TextEditingController();

  //============================================================================
  //! STATE
  //============================================================================

  int _selectedImage = 0;

  final List<String> _images = [];

  final ImagePicker _imagePicker = ImagePicker();

  final LocationService _locationService = LocationService();

  final List<String> _selectedAmenities = [];

  LocationOption? _locationOption;

  String? _detectedAddress;

  double? _latitude;

  double? _longitude;

  LocationStatus _locationStatus = LocationStatus.none;

  bool get _isGpsLoading => _locationStatus == LocationStatus.gpsDetecting;

  bool get _isGpsSelected => _locationStatus == LocationStatus.gpsSelected;

  bool get _isManualLoading => _locationStatus == LocationStatus.manualSaving;

  bool get _isManualSelected =>
      _locationStatus == LocationStatus.manualSelected;

  bool get _isGpsLocked =>
      _locationStatus == LocationStatus.manualSaving ||
      _locationStatus == LocationStatus.manualSelected;

  bool get _isManualLocked =>
      _locationStatus == LocationStatus.gpsDetecting ||
      _locationStatus == LocationStatus.gpsSelected ||
      _locationStatus == LocationStatus.manualSelected;

  //============================================================================
  //! METHODS
  //============================================================================

  void _toggleAmenity(String amenity) {
    setState(() {
      if (_selectedAmenities.contains(amenity)) {
        _selectedAmenities.remove(amenity);
      } else {
        _selectedAmenities.add(amenity);
      }
    });
  }

  Future<void> _pickImages() async {
    final images = await _imagePicker.pickMultiImage();

    if (images.isEmpty) return;

    setState(() {
      _images.addAll(images.map((image) => image.path));
    });
  }

  Future<void> _detectCurrentLocation() async {
    if (_locationStatus == LocationStatus.gpsDetecting) {
      return;
    }

    setState(() {
      _locationStatus = LocationStatus.gpsDetecting;
    });

    try {
      final result = await _locationService.detectCurrentLocation();

      setState(() {
        _detectedAddress = result.address;
        _latitude = result.latitude;
        _longitude = result.longitude;

        _locationStatus = LocationStatus.gpsSelected;
      });
    } catch (e) {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => PrimaryDialog(
          icon: Icons.location_off_rounded,
          iconColor: Colors.red,
          title: 'Location Not Found',
          message:
              'We couldn\'t determine your current location. Please make sure location services are enabled and try again.',
          buttonText: 'OK',
          onPressed: () => Navigator.pop(context),
        ),
      );
    } finally {
      if (mounted && _locationStatus == LocationStatus.gpsDetecting) {
        setState(() {
          _locationStatus = LocationStatus.none;
        });
      }
    }
  }

  Future<void> _saveManualLocation() async {
    try {
      final missingFields = <String>[];

      if (_provinceController.text.trim().isEmpty) {
        missingFields.add('• Province');
      }

      if (_cityController.text.trim().isEmpty) {
        missingFields.add('• City / Municipality');
      }

      if (_barangayController.text.trim().isEmpty) {
        missingFields.add('• Barangay');
      }

      if (missingFields.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) => PrimaryDialog(
            icon: Icons.location_off_rounded,
            iconColor: Colors.orange,
            title: 'Incomplete Address',
            message:
                'Please enter the following before saving your location:\n\n${missingFields.join('\n')}',
            buttonText: 'OK',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );

        return;
      }

      final result = await _locationService.geocodeAddress(
        province: _provinceController.text.trim(),
        city: _cityController.text.trim(),
        barangay: _barangayController.text.trim(),
        street: _streetController.text.trim(),
        landmark: _landmarkController.text.trim(),
      );

      setState(() {
        _detectedAddress = result.address;
        _latitude = result.latitude;
        _longitude = result.longitude;

        _locationStatus = LocationStatus.manualSelected;
      });
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => PrimaryDialog(
          icon: Icons.location_off_rounded,
          iconColor: Colors.red,
          title: 'Location Not Found',
          message:
              'We couldn\'t find the address you entered. Please check the spelling of your province, city/municipality, and barangay, then try again.',
          buttonText: 'OK',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  void _cancelLocationDetection() {
    setState(() {
      _locationStatus = LocationStatus.none;

      _locationOption = null;

      _detectedAddress = null;
      _latitude = null;
      _longitude = null;
    });
  }

  void _removeLocation() {
    setState(() {
      _locationStatus = LocationStatus.none;

      _locationOption = null;

      _detectedAddress = null;
      _latitude = null;
      _longitude = null;

      _provinceController.clear();
      _cityController.clear();
      _barangayController.clear();
      _streetController.clear();
      _landmarkController.clear();
    });
  }

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    _provinceController.dispose();
    _cityController.dispose();
    _barangayController.dispose();
    _streetController.dispose();
    _landmarkController.dispose();

    super.dispose();
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            //==============================================================
            //! TOP BAR
            //==============================================================
            BackButtonHeader(onBackPressed: () => Navigator.pop(context)),

            const SizedBox(height: 20),

            //==============================================================
            //! TITLE
            //==============================================================
            const Text(
              'Add Property',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),

            const SizedBox(height: 24),

            //==============================================================
            //! PROPERTY PHOTOS
            //==============================================================
            AddPropertyPhotosSection(
              images: _images,
              selectedImage: _selectedImage,
              onImageSelected: (index) {
                setState(() {
                  _selectedImage = index;
                });
              },
              onAddPhoto: _pickImages,
            ),

            const SizedBox(height: 32),

            //==============================================================
            //! PROPERTY INFORMATION
            //==============================================================
            AddPropertyInformationSection(
              titleController: _titleController,
              descriptionController: _descriptionController,
            ),

            const SizedBox(height: 32),

            //==============================================================
            //! PROPERTY ADDRESS
            //==============================================================
            LocationSelector(
              selectedOption: _locationOption,
              lockedOption: _isGpsLoading || _isGpsSelected
                  ? LocationOption.manual
                  : _isManualLoading || _isManualSelected
                  ? LocationOption.gps
                  : null,
              onChanged: (option) {
                setState(() {
                  _locationOption = option;

                  if (option == LocationOption.gps) {
                    _provinceController.clear();
                    _cityController.clear();
                    _barangayController.clear();
                    _streetController.clear();
                    _landmarkController.clear();
                  }

                  if (option == LocationOption.manual) {
                    _detectedAddress = null;
                    _latitude = null;
                    _longitude = null;
                  }
                });
              },
            ),

            const SizedBox(height: AppSpacing.lg),

            if (_locationOption == LocationOption.gps)
              CurrentLocationCard(
                address: _detectedAddress,
                onCancelDetection: _cancelLocationDetection,
                isLocked: _isGpsLocked,
                isSelected: _isGpsSelected,
                isLoading: _isGpsLoading,
                onDetectLocation: _detectCurrentLocation,
                onRemoveLocation: _removeLocation,
              ),

            if (_locationOption == LocationOption.manual)
              ManualLocationForm(
                provinceController: _provinceController,
                cityController: _cityController,
                barangayController: _barangayController,
                streetController: _streetController,
                landmarkController: _landmarkController,

                isLocked: _isManualLocked,

                buttonText: _isManualSelected
                    ? 'Remove Location'
                    : 'Save Location',

                buttonColor: _isManualSelected ? Colors.red : AppColors.primary,

                onButtonPressed: _isManualSelected
                    ? _removeLocation
                    : _saveManualLocation,
              ),

            const SizedBox(height: 24),

            //==============================================================
            //! AMENITIES
            //==============================================================
            AddPropertyAmenitiesSection(
              selectedAmenities: _selectedAmenities,
              onAmenityToggled: _toggleAmenity,
            ),

            const SizedBox(height: 20),

            //==============================================================
            //! INFORMATION NOTICE CARD
            //==============================================================
            InformationNoticeCard(
              icon: Icons.auto_awesome_rounded,
              message:
                  'Starting price and preferred gender are automatically '
                  'calculated from your rooms. Property availability can '
                  'be updated anytime from the property settings.',
            ),

            const SizedBox(height: 12),

            //==============================================================
            //! PUBLISH PROPERTY
            //==============================================================
            PrimaryButton(
              text: 'Publish Property',
              onPressed: () {
                // TODO:
                // Publish property.
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
