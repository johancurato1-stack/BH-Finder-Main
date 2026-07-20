import 'package:flutter/material.dart';

import 'package:bh_finder/core/view_models/landlord_property_card_data.dart';

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
        PropertyStat(value: data.totalRooms.toString(), label: 'Rooms'),

        //====================================================================
        //! TOTAL VIEWS
        //====================================================================
        PropertyStat(value: data.totalViews.toString(), label: 'Views'),

        //====================================================================
        //! TOTAL FAVORITES
        //====================================================================
        PropertyStat(value: data.totalFavorites.toString(), label: 'Favorites'),

        //====================================================================
        //! TOTAL INQUIRIES
        //====================================================================
        PropertyStat(value: data.totalInquiries.toString(), label: 'Inquiries'),
      ],
    );
  }
}
