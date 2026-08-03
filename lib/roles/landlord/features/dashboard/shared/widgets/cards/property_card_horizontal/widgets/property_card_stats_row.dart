import 'package:flutter/material.dart';

import 'package:bh_finder/core/ui_models/landlord_property_card_data.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/dashboard/property_stat.dart';

//============================================================================
//! PROPERTY STATS ROW
//============================================================================

class PropertyCardStatsRow extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyCardStatsRow({super.key, required this.data});

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final LandlordPropertyCardData data;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //====================================================================
        //! TOTAL ROOMS
        //====================================================================
        PropertyStat(
          value: data.totalRooms.toString(),
          label: 'Rooms',
          valueColor: Colors.amber.shade700,
          animationOrder: 0,
        ),

        //====================================================================
        //! TOTAL VIEWS
        //====================================================================
        PropertyStat(
          value: data.totalViews.toString(),
          label: 'Views',
          valueColor: Colors.blue.shade600,
          animationOrder: 1,
        ),

        //====================================================================
        //! TOTAL FAVORITES
        //====================================================================
        PropertyStat(
          value: data.totalFavorites.toString(),
          label: 'Favorites',
          valueColor: Colors.red.shade400,
          animationOrder: 2,
        ),

        //====================================================================
        //! TOTAL INQUIRIES
        //====================================================================
        PropertyStat(
          value: data.totalInquiries.toString(),
          label: 'Inquiries',
          valueColor: Colors.green.shade600,
          animationOrder: 3,
        ),
      ],
    );
  }
}
