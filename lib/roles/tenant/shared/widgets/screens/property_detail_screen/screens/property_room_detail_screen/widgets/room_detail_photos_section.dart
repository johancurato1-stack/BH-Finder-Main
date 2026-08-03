import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/image_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/images/app_network_image.dart';
import 'package:bh_finder/shared/widgets/others/section_title.dart';

//============================================================================
//! ROOM DETAIL PHOTOS SECTION
//============================================================================

class RoomDetailPhotosSection extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomDetailPhotosSection({
    super.key,
    required this.images,
    required this.pageController,
    required this.onImageSelected,
    required this.onViewAll,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<ImageModel> images;

  final PageController pageController;

  final VoidCallback onImageSelected;

  final VoidCallback onViewAll;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //==============================================================
        //! HEADER
        //==============================================================
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionTitle(title: 'Room Photos'),

            TextButton(
              onPressed: onViewAll,
              child: const Text(
                'View All',
                style: TextStyle(
                  color: AppColors.primary,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 3),

        //==============================================================
        //! THUMBNAILS
        //==============================================================
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: images.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );

                  onImageSelected();
                },

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),

                  child: SizedBox(
                    width: 80,
                    height: 80,

                    child: AppNetworkImage(
                      imageUrl: images[index].path,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
