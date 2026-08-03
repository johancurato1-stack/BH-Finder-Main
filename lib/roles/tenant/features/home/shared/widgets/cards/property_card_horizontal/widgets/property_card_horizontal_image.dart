import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/ui_models/tenant_property_card_data.dart';
import 'package:bh_finder/shared/widgets/images/app_network_image.dart';

//============================================================================
//! PROPERTY CARD HORIZONTAL IMAGE
//============================================================================

class PropertyCardHorizontalImage extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardHorizontalImage({super.key, required this.data});

  //============================================================================
  //! VARIABLES
  //============================================================================

  final TenantPropertyCardData data;

  //============================================================================
  //! STATUS COLOR
  //============================================================================

  Color get _statusColor {
    switch (data.status) {
      case PropertyStatus.available:
        return const Color(0xFF00E676);

      case PropertyStatus.occupied:
        return const Color(0xFFEF5350);
    }
  }

  //============================================================================
  //! STATUS LABEL
  //============================================================================

  String get _statusLabel {
    switch (data.status) {
      case PropertyStatus.available:
        return 'Available';

      case PropertyStatus.occupied:
        return 'Occupied';
    }
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //======================================================================
        //! COVER IMAGE
        //======================================================================
        Hero(
          tag: data.id,

          child: AppNetworkImage(
            imageUrl: data.coverImageUrl,

            height: 140,

            width: double.infinity,

            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),

        //======================================================================
        //! STATUS BADGE
        //======================================================================
        Positioned(
          top: 10,
          left: 10,

          child: _StatusBadge(color: _statusColor, label: _statusLabel),
        ),

        //======================================================================
        //! PRICE BADGE
        //======================================================================
        Positioned(
          left: 10,
          bottom: 10,

          child: _PriceBadge(price: data.minimumPrice),
        ),
      ],
    );
  }
}

//============================================================================
//! STATUS BADGE
//============================================================================

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.color, required this.label});

  final Color color;

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          const CircleAvatar(radius: 3, backgroundColor: AppColors.white),

          const SizedBox(width: 4),

          Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }
}

//============================================================================
//! PRICE BADGE
//============================================================================

class _PriceBadge extends StatelessWidget {
  const _PriceBadge({required this.price});

  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),

      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: .75),
        borderRadius: BorderRadius.circular(6),
      ),

      child: Text(
        '₱ ${price.toStringAsFixed(0)}/mo',
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
