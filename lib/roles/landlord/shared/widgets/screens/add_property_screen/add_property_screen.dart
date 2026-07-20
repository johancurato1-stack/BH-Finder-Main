import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/shared/widgets/back_button_header.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_photos_section.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_information_section.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_gender_section.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_amenities_section.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_auto_generated_section.dart';

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

  //============================================================================
  //! STATE
  //============================================================================

  int _selectedImage = 0;

  final List<String> _images = ['https://picsum.photos/800/600?1'];

  String _selectedGender = 'Mixed';

  final List<String> _selectedAmenities = [];

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

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void dispose() {
    _titleController.dispose();
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
              onAddPhoto: () {
                // TODO:
                // Pick property photos.
              },
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
            //! GENDER PREFERENCE
            //==============================================================
            AddPropertyGenderSection(
              selectedGender: _selectedGender,
              onGenderChanged: (gender) {
                setState(() {
                  _selectedGender = gender;
                });
              },
            ),

            const SizedBox(height: 32),

            //==============================================================
            //! AMENITIES
            //==============================================================
            AddPropertyAmenitiesSection(
              selectedAmenities: _selectedAmenities,
              onAmenityToggled: _toggleAmenity,
            ),

            const SizedBox(height: 32),

            //==============================================================
            //! AUTO GENERATED
            //==============================================================
            const AddPropertyAutoGeneratedSection(),

            const SizedBox(height: 40),

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
