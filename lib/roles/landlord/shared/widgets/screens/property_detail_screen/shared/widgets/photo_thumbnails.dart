import 'package:flutter/material.dart';
import 'dart:io';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';

//============================================================================
//! PHOTO THUMBNAILS
//============================================================================

class PhotoThumbnails extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PhotoThumbnails({
    super.key,
    required this.images,
    required this.selectedIndex,
    required this.onImageSelected,
    this.onAddPhoto,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<String> images;

  final int selectedIndex;

  final ValueChanged<int> onImageSelected;

  final VoidCallback? onAddPhoto;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length + (onAddPhoto != null ? 1 : 0),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          if (onAddPhoto != null && index == images.length) {
            return GestureDetector(
              onTap: onAddPhoto,
              child: Container(
                width: 72,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.primary),
                ),
                child: const Icon(Icons.add, color: AppColors.primary),
              ),
            );
          }

          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onImageSelected(index),
            child: Container(
              width: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.md - 2),
                child: images[index].startsWith('http')
                    ? Image.network(images[index], fit: BoxFit.cover)
                    : Image.file(File(images[index]), fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }
}
