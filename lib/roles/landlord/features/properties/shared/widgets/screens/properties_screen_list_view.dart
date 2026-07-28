import 'package:flutter/material.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/landlord_property_card_data.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';

import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/cards/add_property_card.dart';
import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/cards/property_card_vertical/property_card_vertical.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/add_property_screen.dart';

//============================================================================
//! PROPERTIES SCREEN LIST VIEW
//============================================================================

class PropertiesScreenListView extends StatefulWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertiesScreenListView({super.key, required this.propertyRepository});

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final PropertyRepository propertyRepository;

  @override
  State<PropertiesScreenListView> createState() =>
      _PropertiesScreenListViewState();
}

//============================================================================
//! STATE
//============================================================================

class _PropertiesScreenListViewState extends State<PropertiesScreenListView> {
  List<LandlordPropertyCardData> _properties = [];

  bool _loading = true;

  //==========================================================================
  //! LIFECYCLE
  //==========================================================================

  @override
  void initState() {
    super.initState();

    _loadProperties();
  }

  //==========================================================================
  //! LOAD PROPERTIES
  //==========================================================================

  Future<void> _loadProperties() async {
    final properties = await widget.propertyRepository
        .getLandlordPropertyCards();

    if (!mounted) return;

    setState(() {
      _properties = properties;
      _loading = false;
    });
  }

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final properties = _properties;

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: properties.length + 1,
      itemBuilder: (context, index) {
        //==============================================================
        //! ADD PROPERTY CARD
        //==============================================================

        if (index == properties.length) {
          return AddPropertyCard(
            onTap: () async {
              final created = await Navigator.push<bool>(
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

              if (!mounted || created != true) return;

              setState(() {
                _loading = true;
              });

              await _loadProperties();
            },
          );
        }

        //==============================================================
        //! PROPERTY CARD
        //==============================================================

        final property = properties[index];

        return PropertyCardVertical(data: property);
      },
    );
  }
}
