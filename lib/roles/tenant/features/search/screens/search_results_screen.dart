import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/repositories/favorite_repository.dart';
import 'package:bh_finder/core/repositories/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories/room_repository.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/core/models/search_filter_model.dart';

import 'package:bh_finder/roles/tenant/features/search/shared/widgets/search_results_screen/empty_search_results_screen.dart';
import 'package:bh_finder/roles/tenant/features/search/shared/widgets/search_results_screen/search_results_screen_header.dart';
import 'package:bh_finder/roles/tenant/features/search/shared/widgets/search_results_screen/search_results_screen_summary.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/property_card_vertical.dart';

import 'package:bh_finder/shared/widgets/animations/animated_entrance.dart';

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
  //! VARIABLES
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
  //! BUILD RESULTS
  //============================================================================

  Widget _buildResults() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_properties.isEmpty) {
      return const EmptySearchResultsScreen();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),

      itemCount: _properties.length,

      itemBuilder: (context, index) {
        return AnimatedEntrance(
          order: index + 2,

          beginOffset: const Offset(-0.25, 0),

          child: PropertyCardVertical(
            property: _properties[index],
            repository: widget.repository,
            roomRepository: widget.roomRepository,
            favoriteRepository: widget.favoriteRepository,
          ),
        );
      },
    );
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
            const AnimatedEntrance(
              order: 0,
              child: SearchResultsScreenHeader(),
            ),

            //==============================================================
            //! SUMMARY
            //==============================================================
            AnimatedEntrance(
              order: 1,

              child: SearchResultsScreenSummary(
                filter: widget.filter,
                resultCount: _properties.length,
              ),
            ),

            const SizedBox(height: 10),

            //==============================================================
            //! RESULTS
            //==============================================================
            Expanded(child: _buildResults()),
          ],
        ),
      ),
    );
  }
}
