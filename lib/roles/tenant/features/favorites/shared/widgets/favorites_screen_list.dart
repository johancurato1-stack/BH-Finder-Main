import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/room_repository.dart';

import 'package:bh_finder/core/view_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/features/favorites/shared/widgets/favorites_screen_empty_saved_state.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/property_card_vertical.dart';

//============================================================================
//! FAVORITES SCREEN LIST
//============================================================================

class FavoritesScreenList extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const FavoritesScreenList({
    super.key,
    required this.propertyRepository,
    required this.roomRepository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final PropertyRepository propertyRepository;

  final RoomRepository roomRepository;

  @override
  State<FavoritesScreenList> createState() => _FavoritesScreenListState();
}

//============================================================================
//! STATE
//============================================================================

class _FavoritesScreenListState extends State<FavoritesScreenList> {
  List<TenantPropertyCardData> _savedProperties = [];

  bool _loading = true;

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _loadProperties();
  }

  //============================================================================
  //! LOAD FAVORITES
  //============================================================================

  Future<void> _loadProperties() async {
    final properties = await widget.propertyRepository.getPropertyCards();

    if (!mounted) return;

    setState(() {
      _savedProperties = properties;

      _loading = false;
    });
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_savedProperties.isEmpty) {
      return const FavoritesScreenEmptySavedState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),

      itemCount: _savedProperties.length,

      itemBuilder: (context, index) {
        final property = _savedProperties[index];

        return PropertyCardVertical(
          property: property,

          repository: widget.propertyRepository,

          roomRepository: widget.roomRepository,
        );
      },
    );
  }
}
