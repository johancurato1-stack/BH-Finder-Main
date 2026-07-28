import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/models/add_room_request.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/view_models/add_room_view_model.dart';
import 'package:bh_finder/core/models/image_model.dart';
import 'package:bh_finder/core/repositories/repositories.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';
import 'package:bh_finder/shared/widgets/dialogs/primary_dialog.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/shared/widgets/back_button_header.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_room_screen/widgets/add_room_gender_section.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_room_screen/widgets/add_room_information_section.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_room_screen/widgets/add_room_photos_section.dart';

//============================================================================
//! ADD ROOM SCREEN
//============================================================================

class AddRoomScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const AddRoomScreen({super.key, required this.propertyId});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String propertyId;

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  //============================================================================
  //! CONTROLLERS
  //============================================================================

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _capacityController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  //============================================================================
  //! VIEW MODEL
  //============================================================================

  final AddRoomViewModel _viewModel = AddRoomViewModel(
    roomRepository: Repositories.instance.roomRepository,
  );

  //============================================================================
  //! STATE
  //============================================================================

  final ImagePicker _imagePicker = ImagePicker();

  int _selectedImage = 0;

  final List<ImageModel> _images = [];

  GenderPreference _selectedGender = GenderPreference.male;

  //============================================================================
  //! IMAGE PICKER
  //============================================================================

  Future<void> _pickImages() async {
    final images = await _imagePicker.pickMultiImage();

    if (images.isEmpty) return;

    setState(() {
      _images.addAll(
        images.map((image) => ImageModel(path: image.path, isLocal: true)),
      );
    });
  }

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

    if (_images.length == 1) {
      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (context) {
          return PrimaryDialog(
            icon: Icons.photo_library_rounded,
            iconColor: Colors.orange,

            title: 'Room Photo Required',

            message: 'A room must have at least one photo.',

            buttonText: 'OK',

            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      );

      return;
    }

    setState(() {
      _images.removeAt(_selectedImage);

      if (_selectedImage >= _images.length) {
        _selectedImage = _images.length - 1;
      }
    });
  }

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _capacityController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }
  //============================================================================
  //! PUBLISH ROOM
  //============================================================================

  Future<void> _publishRoom() async {
    final price = double.tryParse(_priceController.text.trim()) ?? 0;

    final capacity = int.tryParse(_capacityController.text.trim()) ?? 0;

    final request = AddRoomRequest(
      propertyId: widget.propertyId,
      roomNumber: _titleController.text.trim(),
      price: price,
      capacity: capacity,
      description: _descriptionController.text.trim(),
      genderPreference: _selectedGender,
      images: _images,
    );

    final validation = _viewModel.validate(
      photoCount: _images.length,
      title: request.roomNumber,
      price: request.price,
      capacity: request.capacity,
    );

    switch (validation) {
      case AddRoomValidationResult.photos:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload at least one room photo.'),
          ),
        );
        return;

      case AddRoomValidationResult.title:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a room title.')),
        );
        return;

      case AddRoomValidationResult.price:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid room price.')),
        );
        return;

      case AddRoomValidationResult.capacity:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid room capacity.')),
        );
        return;

      case AddRoomValidationResult.success:
        break;
    }

    final success = await _viewModel.createRoom(request);

    if (!mounted) return;

    if (success) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to publish room.')));
    }
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
              'Add Room',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),

            const SizedBox(height: 24),

            //==============================================================
            //! ROOM PHOTOS
            //==============================================================
            AddRoomPhotosSection(
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
            //! ROOM INFORMATION
            //==============================================================
            AddRoomInformationSection(
              titleController: _titleController,
              priceController: _priceController,
              capacityController: _capacityController,
              descriptionController: _descriptionController,
            ),

            const SizedBox(height: 32),

            //==============================================================
            //! GENDER PREFERENCE
            //==============================================================
            AddRoomGenderSection(
              selectedGender: _selectedGender,
              onGenderChanged: (gender) {
                setState(() {
                  _selectedGender = gender;
                });
              },
            ),

            const SizedBox(height: 32),

            //==============================================================
            //! PUBLISH ROOM
            //==============================================================
            PrimaryButton(text: 'Publish Room', onPressed: _publishRoom),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
