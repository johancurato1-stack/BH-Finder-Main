import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/view_models/landlord_property_card_data.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/cards/property_card_horizontal/widgets/property_card_status_tag.dart';

//============================================================================
//! PROPERTY IMAGE
//============================================================================

class PropertyCardImage extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyCardImage({super.key, required this.data});

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final LandlordPropertyCardData data;

  //==========================================================================
  //! STATUS COLOR
  //==========================================================================

  Color _statusColor() {
    switch (data.status) {
      case PropertyStatus.available:
        return Colors.green;

      case PropertyStatus.occupied:
        return Colors.red;
    }
  }

  //==========================================================================
  //! STATUS LABEL
  //==========================================================================

  String _statusLabel() {
    switch (data.status) {
      case PropertyStatus.available:
        return 'Available';

      case PropertyStatus.occupied:
        return 'Occupied';
    }
  }

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: Image.network(
            data.coverImageUrl,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        Positioned(
          top: 12,
          right: 12,
          child: PropertyCardStatusTag(
            label: _statusLabel(),
            color: _statusColor(),
          ),
        ),
      ],
    );
  }
}
