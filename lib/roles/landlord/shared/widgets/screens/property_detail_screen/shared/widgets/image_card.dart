import 'dart:io';

import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_radius.dart';

//============================================================================
//! IMAGE CARD
//============================================================================

class ImageCard extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ImageCard({
    super.key,
    required this.imageUrl,
    this.height = 250,
    this.onDelete,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String imageUrl;

  final double height;

  final VoidCallback? onDelete;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final image = imageUrl.startsWith('http')
        ? Image.network(
            imageUrl,
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
          )
        : Image.file(
            File(imageUrl),
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Stack(
        children: [
          image,

          if (onDelete != null)
            Positioned(
              top: 12,
              right: 12,
              child: Material(
                color: Colors.red,
                shape: const CircleBorder(),
                elevation: 4,
                child: InkWell(
                  onTap: onDelete,
                  customBorder: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
