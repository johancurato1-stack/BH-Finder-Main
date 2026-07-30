import 'package:bh_finder/core/favorites/respositories/favorite_repository.dart';
import 'package:flutter/material.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

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
    required this.favoriteRepository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final PropertyRepository propertyRepository;

  final RoomRepository roomRepository;

  final FavoriteRepository favoriteRepository;

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
    final properties = await widget.propertyRepository
        .getFavoritePropertyCards();

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

      itemBuilder: (context, index) => PropertyCardVertical(
        property: _savedProperties[index],
        repository: widget.propertyRepository,
        roomRepository: widget.roomRepository,
        showAmenities: false,
        favoriteRepository: widget.favoriteRepository,
      ),
    );
  }
}
