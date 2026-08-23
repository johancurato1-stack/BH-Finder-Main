import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/shared/widgets/back_button_header.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_photos_section.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_information_section.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_amenities_section.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_availability_section.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_location_section.dart';

import 'package:bh_finder/shared/widgets/location/location_selector.dart';
import 'package:bh_finder/shared/widgets/cards/information_notice_card.dart';
import 'package:bh_finder/shared/widgets/dialogs/primary_dialog.dart';

import 'package:bh_finder/shared/widgets/services/location_service.dart';

import 'package:bh_finder/core/view_models/add_property_view_model.dart';
import 'package:bh_finder/core/models/add_property_request.dart';
import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/repositories/repositories/repositories.dart';
import 'package:bh_finder/core/ui_models/property_detail_data.dart';
import 'package:bh_finder/core/models/image_model.dart';

import 'package:bh_finder/shared/widgets/loading/publishing_loading_screen.dart';

import 'package:bh_finder/roles/landlord/shared/models/landlord_property_origin.dart';

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
  const AddPropertyScreen({super.key, this.property, this.origin});

  final PropertyDetailData? property;

  final LandlordPropertyOrigin? origin;

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

  final List<ImageModel> _images = [];

  final ImagePicker _imagePicker = ImagePicker();

  final LocationService _locationService = LocationService();

  final AddPropertyViewModel _viewModel = AddPropertyViewModel(
    propertyRepository: Repositories.instance.propertyRepository,
  );

  final List<Amenity> _selectedAmenities = [];

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

  bool get _isEditing => widget.property != null;

  PropertyStatus _selectedStatus = PropertyStatus.available;

  //============================================================================
  //! DIALOG HELPER
  //============================================================================

  Future<void> _showMessageDialog({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String message,
  }) {
    return showDialog(
      context: context,
      builder: (context) => PrimaryDialog(
        icon: icon,
        iconColor: iconColor,
        title: title,
        message: message,
        buttonText: 'OK',
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  //============================================================================
  //! PHOTO METHODS
  //============================================================================

  Future<void> _deleteSelectedPhoto() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return PrimaryDialog(
          icon: Icons.delete_rounded,
          iconColor: Colors.red,
          title: 'Delete Photo',
          message: 'Are you sure you want to delete this photo?',
          secondaryButtonText: 'Cancel',
          onSecondaryPressed: () {
            Navigator.pop(context, false);
          },
          buttonText: 'Delete',
          onPressed: () {
            Navigator.pop(context, true);
          },
        );
      },
    );

    if (shouldDelete != true) return;

    if (_images.isEmpty) return;

    setState(() {
      _images.removeAt(_selectedImage);

      if (_images.isEmpty) {
        _selectedImage = 0;
      } else if (_selectedImage >= _images.length) {
        _selectedImage = _images.length - 1;
      }
    });
  }

  Future<void> _pickImages() async {
    final images = await _imagePicker.pickMultiImage();

    if (images.isEmpty) return;

    setState(() {
      _images.addAll(
        images.map((image) => ImageModel(path: image.path, isLocal: true)),
      );
    });
  }

  //============================================================================
  //! AMENITIES
  //============================================================================

  void _toggleAmenity(Amenity amenity) {
    setState(() {
      if (_selectedAmenities.contains(amenity)) {
        _selectedAmenities.remove(amenity);
      } else {
        _selectedAmenities.add(amenity);
      }
    });
  }

  //============================================================================
  //! LOCATION
  //============================================================================

  Future<void> _detectCurrentLocation() async {
    if (_locationStatus == LocationStatus.gpsDetecting) {
      return;
    }

    setState(() {
      _locationStatus = LocationStatus.gpsDetecting;
    });

    try {
      final result = await _locationService.detectCurrentLocation();

      if (!mounted) return;

      setState(() {
        _detectedAddress = result.address;
        _latitude = result.latitude;
        _longitude = result.longitude;

        _locationStatus = LocationStatus.gpsSelected;
      });
    } catch (e) {
      if (!mounted) return;

      await _showMessageDialog(
        icon: Icons.location_off_rounded,
        iconColor: Colors.red,
        title: 'Location Not Found',
        message:
            'We couldn\'t determine your current location. Please make sure location services are enabled and try again.',
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
        await _showMessageDialog(
          icon: Icons.location_off_rounded,
          iconColor: Colors.orange,
          title: 'Incomplete Address',
          message:
              'Please enter the following before saving your location:\n\n${missingFields.join('\n')}',
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

      if (!mounted) return;

      setState(() {
        _detectedAddress = result.address;
        _latitude = result.latitude;
        _longitude = result.longitude;

        _locationStatus = LocationStatus.manualSelected;
      });
    } catch (e) {
      if (!mounted) return;

      await _showMessageDialog(
        icon: Icons.location_off_rounded,
        iconColor: Colors.red,
        title: 'Location Not Found',
        message:
            'We couldn\'t find the address you entered. Please check the spelling of your province, city/municipality, and barangay, then try again.',
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
  //! RETURN TO PREVIOUS SCREEN
  //============================================================================

  void _returnWithResult() {
    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      Navigator.of(context).pop(true);
    });
  }

  //============================================================================
  //! PUBLISH / UPDATE PROPERTY
  //============================================================================

  Future<void> _publishProperty() async {
    //==============================================================
    //! PROPERTY PHOTOS
    //==============================================================

    if (_images.isEmpty) {
      await _showMessageDialog(
        icon: Icons.photo_library_rounded,
        iconColor: Colors.orange,
        title: 'Property Photo Required',
        message: 'Please add at least one photo of your property.',
      );

      return;
    }

    //==============================================================
    //! PROPERTY INFORMATION
    //==============================================================

    if (_titleController.text.trim().isEmpty) {
      await _showMessageDialog(
        icon: Icons.home_rounded,
        iconColor: Colors.orange,
        title: 'Property Title Required',
        message: 'Please enter a title for your property.',
      );

      return;
    }

    //==============================================================
    //! LOCATION
    //==============================================================

    if (_locationStatus != LocationStatus.gpsSelected &&
        _locationStatus != LocationStatus.manualSelected) {
      await _showMessageDialog(
        icon: Icons.location_on_rounded,
        iconColor: Colors.orange,
        title: 'Property Location Required',
        message: 'Please save your property location before publishing.',
      );

      return;
    }

    //==============================================================
    //! AMENITIES
    //==============================================================

    if (_selectedAmenities.isEmpty) {
      await _showMessageDialog(
        icon: Icons.checklist_rounded,
        iconColor: Colors.orange,
        title: 'Amenities Required',
        message: 'Please select at least one amenity.',
      );

      return;
    }

    //==============================================================
    //! CREATE REQUEST
    //==============================================================

    final request = AddPropertyRequest(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? 'No description provided.'
          : _descriptionController.text.trim(),
      address: _detectedAddress!,
      latitude: _latitude!,
      longitude: _longitude!,
      images: _images,
      amenities: _selectedAmenities,
      status: _selectedStatus,
    );

    //==============================================================
    //! PUBLISH / UPDATE
    //==============================================================

    final success = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => PublishingLoadingScreen(
          title: _isEditing ? 'Updating Property' : 'Publishing Property',
          subtitle: _isEditing
              ? 'Updating your property information and photos.'
              : 'Publishing your property and photos.',
          operation: _isEditing
              ? PublishingOperation.update
              : PublishingOperation.publish,
          steps: [
            const PublishingLoadingStep(
              title: 'Saving property information',
              status: PublishingStepStatus.current,
            ),
            const PublishingLoadingStep(
              title: 'Uploading property photos',
              status: PublishingStepStatus.pending,
            ),
            const PublishingLoadingStep(
              title: 'Finalizing property',
              status: PublishingStepStatus.pending,
            ),
          ],
          onPublish: () {
            if (_isEditing) {
              return _viewModel.updateProperty(
                propertyId: widget.property!.id,
                request: request,
              );
            }

            return _viewModel.createProperty(request);
          },
        ),
      ),
    );

    if (!mounted) return;

    if (success == true) {
      _returnWithResult();
    }
  }

  //============================================================================
  //! DELETE PROPERTY
  //============================================================================

  Future<void> _deleteProperty() async {
    final success = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => PublishingLoadingScreen(
          title: 'Deleting Property',
          subtitle: 'Deleting your property and associated data.',
          operation: PublishingOperation.delete,
          steps: const [
            PublishingLoadingStep(
              title: 'Deleting property information',
              status: PublishingStepStatus.current,
            ),
            PublishingLoadingStep(
              title: 'Deleting rooms and images',
              status: PublishingStepStatus.pending,
            ),
            PublishingLoadingStep(
              title: 'Finalizing deletion',
              status: PublishingStepStatus.pending,
            ),
          ],
          onPublish: () {
            return _viewModel.deleteProperty(widget.property!.id);
          },
        ),
      ),
    );

    if (!mounted) return;

    if (success == true) {
      _returnWithResult();
    }
  }

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    if (!_isEditing) return;

    final property = widget.property!;

    _titleController.text = property.title;
    _descriptionController.text = property.description;

    _selectedStatus = property.status;

    _images.addAll(property.images);

    _selectedAmenities.addAll(property.amenities);

    _detectedAddress = property.address;
    _latitude = property.latitude;
    _longitude = property.longitude;

    _locationOption = LocationOption.gps;
    _locationStatus = LocationStatus.gpsSelected;
  }

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
            Text(
              _isEditing ? 'Edit Property' : 'Add Property',
              style: const TextStyle(
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
              onDeletePhoto: _deleteSelectedPhoto,
            ),

            const SizedBox(height: 32),

            //==============================================================
            //! AVAILABILITY
            //==============================================================
            if (_isEditing) ...[
              AddPropertyAvailabilitySection(
                status: _selectedStatus,
                onChanged: (status) {
                  setState(() {
                    _selectedStatus = status;
                  });
                },
              ),

              const SizedBox(height: 32),
            ],

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
            AddPropertyLocationSection(
              locationOption: _locationOption,
              onOptionChanged: (option) {
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
              isGpsLoading: _isGpsLoading,
              isGpsSelected: _isGpsSelected,
              isGpsLocked: _isGpsLocked,
              isManualLoading: _isManualLoading,
              isManualSelected: _isManualSelected,
              isManualLocked: _isManualLocked,
              detectedAddress: _detectedAddress,
              onDetectLocation: _detectCurrentLocation,
              onCancelDetection: _cancelLocationDetection,
              onRemoveLocation: _removeLocation,
              provinceController: _provinceController,
              cityController: _cityController,
              barangayController: _barangayController,
              streetController: _streetController,
              landmarkController: _landmarkController,
              onSaveManualLocation: _saveManualLocation,
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

            if (_isEditing) const SizedBox(height: 30),

            //==============================================================
            //! INFORMATION NOTICE CARD
            //==============================================================
            if (!_isEditing)
              InformationNoticeCard(
                icon: Icons.auto_awesome_rounded,
                message:
                    'Starting price and preferred gender are automatically '
                    'calculated from your rooms. Property availability can '
                    'be updated anytime from the property settings.',
              ),

            if (!_isEditing) const SizedBox(height: 20),

            //==============================================================
            //! PUBLISH / UPDATE PROPERTY
            //==============================================================
            PrimaryButton(
              text: _isEditing ? 'Update Property' : 'Publish Property',
              onPressed: _publishProperty,
            ),

            //==============================================================
            //! DELETE PROPERTY
            //==============================================================
            if (_isEditing) ...[
              const Divider(
                height: 32,
                thickness: .5,
                color: AppColors.tertiary,
              ),

              const SizedBox(height: 12),

              OutlinedButton(
                onPressed: _deleteProperty,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Delete Property',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
