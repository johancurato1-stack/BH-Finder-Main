import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/favorites/respositories/favorite_repository.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/features/search/models/search_filter_model.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/property_card_vertical.dart';

import 'package:bh_finder/roles/tenant/features/search/shared/widgets/search_results_screen/search_results_screen_header.dart';
import 'package:bh_finder/roles/tenant/features/search/shared/widgets/search_results_screen/search_results_screen_summary.dart';
import 'package:bh_finder/roles/tenant/features/search/shared/widgets/search_results_screen/empty_search_results_screen.dart';

//============================================================================
//! SEARCH RESULTS SCREEN
//============================================================================

class SearchResultsScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SearchResultsScreen({
    super.key,
    required this.filter,
    required this.repository,
    required this.roomRepository,
    required this.favoriteRepository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final SearchFilterModel filter;

  final PropertyRepository repository;

  final RoomRepository roomRepository;

  final FavoriteRepository favoriteRepository;

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  //============================================================================
  //! STATE
  //============================================================================

  bool _isLoading = true;

  List<TenantPropertyCardData> _properties = [];

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  //============================================================================
  //! LOAD RESULTS
  //============================================================================

  Future<void> _loadResults() async {
    final results = await widget.repository.searchProperties(widget.filter);

    if (!mounted) return;

    setState(() {
      _properties = results;
      _isLoading = false;
    });
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
            //==========================================================================
            //! HEADER
            //==========================================================================
            const SearchResultsScreenHeader(),

            //==========================================================================
            //! SUMMARY
            //==========================================================================
            SearchResultsScreenSummary(
              filter: widget.filter,
              resultCount: _properties.length,
            ),

            const SizedBox(height: 10),

            //==========================================================================
            //! RESULTS
            //==========================================================================
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _properties.isEmpty
                  ? const EmptySearchResultsScreen()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemCount: _properties.length,
                      itemBuilder: (context, index) {
                        return PropertyCardVertical(
                          property: _properties[index],
                          repository: widget.repository,
                          roomRepository: widget.roomRepository,
                          favoriteRepository: widget.favoriteRepository,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
