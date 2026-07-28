import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/image_model.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/shared/widgets/image_card.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/shared/widgets/photo_thumbnails.dart';
import 'package:bh_finder/shared/widgets/others/section_title.dart';

//============================================================================
//! ADD ROOM PHOTOS SECTION
//============================================================================

class AddRoomPhotosSection extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const AddRoomPhotosSection({
    super.key,
    required this.images,
    required this.selectedImage,
    required this.onImageSelected,
    required this.onAddPhoto,
    this.onDeletePhoto,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<ImageModel> images;

  final int selectedImage;

  final ValueChanged<int> onImageSelected;

  final VoidCallback onAddPhoto;

  final VoidCallback? onDeletePhoto;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //==============================================================
        //! TITLE
        //==============================================================
        const SectionTitle(title: 'Room Photos'),

        const SizedBox(height: 8),

        const Text(
          'Upload clear photos of your boarding house rooms.',
          style: TextStyle(fontSize: 13, height: 1.4),
        ),

        const SizedBox(height: 16),

        //==============================================================
        //! MAIN IMAGE
        //==============================================================
        if (images.isNotEmpty)
          ImageCard(
            imageUrl: images[selectedImage].path,
            onDelete: onDeletePhoto,
          )
        else
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade200,
            ),
            alignment: Alignment.center,
            child: const Text('No photos selected'),
          ),

        const SizedBox(height: 16),

        //==============================================================
        //! THUMBNAILS
        //==============================================================
        PhotoThumbnails(
          images: images,
          selectedIndex: selectedImage,
          onImageSelected: onImageSelected,
          onAddPhoto: onAddPhoto,
        ),
      ],
    );
  }
}
