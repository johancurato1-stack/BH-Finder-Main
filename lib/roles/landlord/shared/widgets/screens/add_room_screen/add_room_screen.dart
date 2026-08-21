import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';

import 'package:bh_finder/core/models/add_room_request.dart';
import 'package:bh_finder/core/ui_models/room_detail_data.dart';
import 'package:bh_finder/core/view_models/add_room_view_model.dart';
import 'package:bh_finder/core/models/image_model.dart';
import 'package:bh_finder/core/repositories/repositories/repositories.dart';

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
  const AddRoomScreen({super.key, required this.propertyId, this.room});

  final String propertyId;

  final RoomDetailData? room;

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

  final List<ImageModel> _images = [];

  int _selectedImage = 0;

  GenderPreference? _selectedGender;

  bool get _isEditing => widget.room != null;

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

    setState(() {
      _images.removeAt(_selectedImage);

      if (_images.isEmpty) {
        _selectedImage = 0;
      } else if (_selectedImage >= _images.length) {
        _selectedImage = _images.length - 1;
      }
    });
  }

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    if (!_isEditing) return;

    final room = widget.room!;

    _titleController.text = room.title;
    _priceController.text = room.price.toStringAsFixed(0);
    _capacityController.text = room.capacity.toString();
    _descriptionController.text = room.description;

    _selectedGender = room.genderPreference;

    _images.addAll(room.images);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _capacityController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  //============================================================================
  //! SAVE ROOM
  //============================================================================

  Future<void> _saveRoom() async {
    final title = _titleController.text.trim();

    final price = double.tryParse(_priceController.text.trim()) ?? 0;

    final capacity = int.tryParse(_capacityController.text.trim()) ?? 0;

    final description = _descriptionController.text.trim().isEmpty
        ? 'No description provided.'
        : _descriptionController.text.trim();

    final validation = _viewModel.validate(
      photoCount: _images.length,
      title: title,
      price: price,
      capacity: capacity,
      description: description,
      gender: _selectedGender,
    );

    switch (validation) {
      case AddRoomValidationResult.photos:
        await showDialog(
          context: context,
          builder: (_) => PrimaryDialog(
            icon: Icons.photo_library_rounded,
            iconColor: Colors.orange,
            title: 'Room Photos Required',
            message: 'Please upload at least one room photo.',
            buttonText: 'OK',
            onPressed: () => Navigator.pop(context),
          ),
        );
        return;

      case AddRoomValidationResult.title:
        await showDialog(
          context: context,
          builder: (_) => PrimaryDialog(
            icon: Icons.meeting_room_rounded,
            iconColor: Colors.orange,
            title: 'Room Title Required',
            message: 'Please enter a room title.',
            buttonText: 'OK',
            onPressed: () => Navigator.pop(context),
          ),
        );
        return;

      case AddRoomValidationResult.price:
        await showDialog(
          context: context,
          builder: (_) => PrimaryDialog(
            icon: Icons.payments_rounded,
            iconColor: Colors.orange,
            title: 'Room Price Required',
            message: 'Please enter a valid room price.',
            buttonText: 'OK',
            onPressed: () => Navigator.pop(context),
          ),
        );
        return;

      case AddRoomValidationResult.capacity:
        await showDialog(
          context: context,
          builder: (_) => PrimaryDialog(
            icon: Icons.groups_rounded,
            iconColor: Colors.orange,
            title: 'Room Capacity Required',
            message: 'Please enter a valid room capacity.',
            buttonText: 'OK',
            onPressed: () => Navigator.pop(context),
          ),
        );
        return;

      case AddRoomValidationResult.description:
        break;

      case AddRoomValidationResult.gender:
        await showDialog(
          context: context,
          builder: (_) => PrimaryDialog(
            icon: Icons.people_alt_rounded,
            iconColor: Colors.orange,
            title: 'Gender Preference Required',
            message: 'Please select who this room is intended for.',
            buttonText: 'OK',
            onPressed: () => Navigator.pop(context),
          ),
        );
        return;

      case AddRoomValidationResult.success:
        break;
    }

    final request = AddRoomRequest(
      propertyId: widget.propertyId,
      roomNumber: title,
      price: price,
      capacity: capacity,
      description: description,
      genderPreference: _selectedGender!,
      images: _images,
    );

    bool success;

    if (_isEditing) {
      success = await _viewModel.updateRoom(
        roomId: widget.room!.id,
        request: request,
      );
    } else {
      success = await _viewModel.createRoom(request);
    }

    if (!mounted) return;

    if (success) {
      Navigator.pop(context, true);
      return;
    }

    await showDialog(
      context: context,
      builder: (_) => PrimaryDialog(
        icon: Icons.error_rounded,
        iconColor: Colors.red,
        title: _isEditing ? 'Update Failed' : 'Publish Failed',
        message: _isEditing
            ? 'Failed to update room. Please try again.'
            : 'Failed to publish room. Please try again.',
        buttonText: 'OK',
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  //============================================================================
  //! DELETE ROOM
  //============================================================================

  Future<void> _deleteRoom() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (_) => PrimaryDialog(
        icon: Icons.delete_rounded,
        iconColor: Colors.red,
        title: 'Delete Room?',
        message:
            'This will permanently delete:\n\n'
            '• Room\n'
            '• Images\n\n'
            'This action cannot be undone.',
        secondaryButtonText: 'Cancel',
        onSecondaryPressed: () => Navigator.pop(context, false),
        buttonText: 'Delete',
        onPressed: () => Navigator.pop(context, true),
      ),
    );

    if (shouldDelete != true) return;

    final success = await _viewModel.deleteRoom(widget.room!.id);

    if (!mounted) return;

    if (success) {
      Navigator.pop(context, true);
      return;
    }

    await showDialog(
      context: context,
      builder: (_) => PrimaryDialog(
        icon: Icons.error_rounded,
        iconColor: Colors.red,
        title: 'Delete Failed',
        message: 'Failed to delete room. Please try again.',
        buttonText: 'OK',
        onPressed: () => Navigator.pop(context),
      ),
    );
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
              _isEditing ? 'Edit Room' : 'Add Room',
              style: const TextStyle(
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
            //! PUBLISH / UPDATE ROOM
            //==============================================================
            PrimaryButton(
              text: _isEditing ? 'Update Room' : 'Publish Room',
              onPressed: _saveRoom,
            ),

            if (_isEditing)
              const Divider(
                height: 32,
                thickness: .5,
                color: AppColors.tertiary,
              ),

            //==============================================================
            //! DELETE ROOM
            //==============================================================
            if (_isEditing) ...[
              const SizedBox(height: 12),

              OutlinedButton(
                onPressed: _deleteRoom,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
                child: const Text(
                  'Delete Room',
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
