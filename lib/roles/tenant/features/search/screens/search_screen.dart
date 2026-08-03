import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/repositories/favorite_repository.dart';
import 'package:bh_finder/core/repositories/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories/room_repository.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/animations/animated_entrance.dart';
import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';

import 'package:bh_finder/core/models/search_filter_model.dart';

import 'package:bh_finder/roles/tenant/features/search/screens/search_results_screen.dart';

import 'package:bh_finder/roles/tenant/features/search/shared/widgets/search_screen/search_screen_filters_body.dart';
import 'package:bh_finder/roles/tenant/features/search/shared/widgets/search_screen/search_screen_header.dart';

//============================================================================
//! SEARCH SCREEN
//============================================================================

class SearchScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SearchScreen({
    super.key,
    required this.onBackPressed,
    required this.propertyRepository,
    required this.roomRepository,
    required this.favoriteRepository,
  });

  //============================================================================
  //! CALLBACKS
  //============================================================================

  final VoidCallback onBackPressed;

  //============================================================================
  //! REPOSITORIES
  //============================================================================

  final PropertyRepository propertyRepository;

  final RoomRepository roomRepository;

  final FavoriteRepository favoriteRepository;

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  //============================================================================
  //! CONTROLLERS
  //============================================================================

  final TextEditingController _searchController = TextEditingController();

  //============================================================================
  //! FILTER
  //============================================================================

  final SearchFilterModel _filter = SearchFilterModel();

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  //============================================================================
  //! RESET SEARCH
  //============================================================================

  void resetSearch() {
    setState(() {
      _searchController.clear();
      _filter.reset();
    });
  }

  //============================================================================
  //! REFRESH
  //============================================================================

  void _refresh() {
    setState(() {});
  }

  //============================================================================
  //! SHOW RESULTS
  //============================================================================

  void _openResults() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchResultsScreen(
          filter: _filter.copyWith(query: _searchController.text),
          repository: widget.propertyRepository,
          roomRepository: widget.roomRepository,
          favoriteRepository: widget.favoriteRepository,
        ),
      ),
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
          children: [
            //==============================================================
            //! HEADER
            //==============================================================
            AnimatedEntrance(
              order: 0,
              child: SearchScreenHeader(onBackPressed: widget.onBackPressed),
            ),

            //==============================================================
            //! FILTERS
            //==============================================================
            Expanded(
              child: AnimatedEntrance(
                order: 1,
                child: SearchScreenFilterBody(
                  controller: _searchController,
                  filter: _filter,
                  onReset: resetSearch,
                  onChanged: _refresh,
                ),
              ),
            ),

            //==============================================================
            //! BUTTON
            //==============================================================
            AnimatedEntrance(
              order: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 46),
                child: PrimaryButton(
                  text: 'Show Results',
                  onPressed: _openResults,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
