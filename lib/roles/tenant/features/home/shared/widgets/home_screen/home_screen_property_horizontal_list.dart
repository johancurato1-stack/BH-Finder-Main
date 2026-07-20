import 'package:flutter/material.dart';

import 'package:bh_finder/core/view_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/features/home/shared/widgets/cards/property_card_horizontal/property_card_horizontal.dart';

//============================================================================
//! HOME SCREEN PROPERTY HORIZONTAL LIST
//============================================================================

class HomeScreenPropertyHorizontalList extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const HomeScreenPropertyHorizontalList({super.key, required this.properties});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<TenantPropertyCardData> properties;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final property = properties[index];

          return Row(
            children: [
              SizedBox(
                width: 160,
                height: 255,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: PropertyCardHorizontal(data: property),
                ),
              ),

              const SizedBox(width: 16),
            ],
          );
        },
      ),
    );
  }
}
