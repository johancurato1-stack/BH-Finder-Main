import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/favorites/respositories/favorite_repository.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/features/search/models/search_filter_model.dart';

import 'package:bh_finder/roles/tenant/features/favorites/shared/widgets/favorites_screen_header.dart';
import 'package:bh_finder/roles/tenant/features/favorites/shared/widgets/favorites_screen_list.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet.dart';

//============================================================================
//! FAVORITES SCREEN
//============================================================================

class FavoritesScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const FavoritesScreen({
    super.key,
    required this.onBackPressed,
    required this.propertyRepository,
    required this.roomRepository,
    required this.favoriteRepository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onBackPressed;

  final PropertyRepository propertyRepository;

  final RoomRepository roomRepository;

  final FavoriteRepository favoriteRepository;

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _FavoritesScreenState extends State<FavoritesScreen> {
  //============================================================================
  //! STATE
  //============================================================================

  late SearchFilterModel _filter;

  bool _isLoading = true;

  List<TenantPropertyCardData> _savedProperties = [];

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _filter = SearchFilterModel();

    _loadProperties();
  }

  //============================================================================
  //! LOAD FAVORITES
  //============================================================================

  Future<void> _loadProperties() async {
    final properties = await widget.propertyRepository
        .searchFavoritePropertyCards(_filter);

    if (!mounted) return;

    setState(() {
      _savedProperties = properties;
      _isLoading = false;
    });
  }

  //============================================================================
  //! FILTER
  //============================================================================

  Future<void> _showFilter() async {
    final filter = await FilterBottomSheet.show(
      context,
      initialFilter: _filter,
    );

    if (filter == null) return;

    setState(() {
      _filter = filter;
      _isLoading = true;
    });

    await _loadProperties();
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //==============================================================
            //! HEADER
            //==============================================================
            FavoritesScreenHeader(
              onBackPressed: widget.onBackPressed,
              onFilterPressed: _showFilter,
            ),

            //==============================================================
            //! SAVED LIST
            //==============================================================
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : FavoritesScreenList(
                      properties: _savedProperties,
                      propertyRepository: widget.propertyRepository,
                      roomRepository: widget.roomRepository,
                      favoriteRepository: widget.favoriteRepository,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
