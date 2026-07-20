import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/property_repository.dart';
import 'package:bh_finder/core/view_models/landlord_property_card_data.dart';

import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/cards/add_property_card.dart';
import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/cards/property_card_vertical/property_card_vertical.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/add_property_screen.dart';

class PropertiesScreenListView extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertiesScreenListView({super.key});

  //==========================================================================
  //! REPOSITORIES
  //==========================================================================

  static final PropertyRepository _propertyRepository = PropertyRepository();

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    final List<LandlordPropertyCardData> properties = _propertyRepository
        .getLandlordPropertyCards();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: properties.length + 1,
      itemBuilder: (context, index) {
        //====================================================================
        //! ADD PROPERTY CARD
        //====================================================================

        if (index == properties.length) {
          return AddPropertyCard(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, animation, __) => const AddPropertyScreen(),
                  transitionsBuilder: (_, animation, __, child) {
                    final offsetAnimation =
                        Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOut,
                          ),
                        );

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
          );
        }

        //====================================================================
        //! PROPERTY CARD
        //====================================================================

        final property = properties[index];

        return PropertyCardVertical(data: property);
      },
    );
  }
}
