import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/favorites/respositories/favorite_repository.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/features/search/models/search_filter_model.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/see_all_screen/widgets/see_all_property_list_view.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/see_all_screen/widgets/see_all_header.dart';
import 'package:bh_finder/roles/tenant/features/search/shared/widgets/search_results_screen/empty_search_results_screen.dart';

//============================================================================
//! SEE ALL SCREEN
//============================================================================

class SeeAllScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SeeAllScreen({
    super.key,
    required this.title,
    required this.repository,
    required this.roomRepository,
    required this.favoriteRepository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String title;

  final PropertyRepository repository;

  final RoomRepository roomRepository;

  final FavoriteRepository favoriteRepository;

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  //============================================================================
  //! STATE
  //============================================================================

  late SearchFilterModel _filter;

  bool _isLoading = true;

  List<TenantPropertyCardData> _properties = [];

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
  //! LOAD PROPERTIES
  //============================================================================

  Future<void> _loadProperties() async {
    final results = await widget.repository.searchProperties(_filter);

    if (!mounted) return;

    setState(() {
      _properties = results;
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
          children: [
            //==================================================================
            //! HEADER
            //==================================================================
            SeeAllHeader(
              title: widget.title,
              onBack: () => Navigator.pop(context),
              onFilter: _showFilter,
            ),

            //==================================================================
            //! PROPERTY LIST
            //==================================================================
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _properties.isEmpty
                  ? const EmptySearchResultsScreen()
                  : PropertyListView(
                      properties: _properties,
                      repository: widget.repository,
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
