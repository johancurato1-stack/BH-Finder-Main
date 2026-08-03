import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! APP NETWORK IMAGE
//============================================================================

class AppNetworkImage extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String imageUrl;

  final double? height;

  final double? width;

  final BoxFit fit;

  final BorderRadius? borderRadius;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,

      child: Image.network(
        imageUrl,
        height: height,
        width: width,
        fit: fit,

        frameBuilder: (context, child, frame, _) {
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            child: child,
          );
        },

        loadingBuilder: (context, child, progress) {
          if (progress == null) {
            return child;
          }

          return _ImagePlaceholder(
            text: 'Loading image...',
            icon: Icons.image_outlined,
            height: height,
            width: width,
          );
        },

        errorBuilder: (_, __, ___) {
          return _ImagePlaceholder(
            text: 'Image unavailable',
            icon: Icons.image_not_supported_outlined,
            height: height,
            width: width,
          );
        },
      ),
    );
  }
}

//============================================================================
//! IMAGE PLACEHOLDER
//============================================================================

class _ImagePlaceholder extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const _ImagePlaceholder({
    required this.text,
    required this.icon,
    this.height,
    this.width,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String text;

  final IconData icon;

  final double? height;

  final double? width;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,

      color: Colors.grey.shade100,

      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Container(
              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),

              child: Icon(icon, size: 28, color: AppColors.tertiary),
            ),

            const SizedBox(height: 12),

            Text(
              text,
              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
                color: AppColors.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
