import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';
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

  const AddRoomScreen({super.key});

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  //============================================================================
  //! CONTROLLERS
  //============================================================================

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  //============================================================================
  //! STATE
  //============================================================================

  int _selectedImage = 0;

  final List<String> _images = ['https://picsum.photos/800/600?1'];

  String _selectedGender = 'Male';

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();

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
              onAddPhoto: () {
                // TODO:
                // Pick room photos.
              },
            ),

            const SizedBox(height: 32),

            //==============================================================
            //! ROOM INFORMATION
            //==============================================================
            AddRoomInformationSection(
              titleController: _titleController,
              priceController: _priceController,
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
            PrimaryButton(
              text: 'Publish Room',
              onPressed: () {
                // TODO:
                // Publish room.
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
