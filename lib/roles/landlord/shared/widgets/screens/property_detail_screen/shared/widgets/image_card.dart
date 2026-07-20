import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_radius.dart';

//============================================================================
//! IMAGE CARD
//============================================================================

class ImageCard extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ImageCard({super.key, required this.imageUrl, this.height = 250});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String imageUrl;

  final double height;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Image.network(
        imageUrl,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
