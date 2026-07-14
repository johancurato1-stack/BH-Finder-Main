import 'package:flutter/material.dart';

import 'package:bh_finder/features/search/models/search_filter_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/features/search/widgets/search_header.dart';
import 'package:bh_finder/features/search/widgets/search_filters_body.dart';

import 'package:bh_finder/shared/widgets/buttons/custom_button.dart';

import 'package:bh_finder/features/search/screens/search_results_screen.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback onBackPressed;

  const SearchScreen({super.key, required this.onBackPressed});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //============================================================================
  //! CONTROLLERS
  //============================================================================

  final TextEditingController _searchController = TextEditingController();

  //============================================================================
  //! SEARCH FILTER
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
  //! RESET FILTERS
  //============================================================================

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _filter.reset();
    });
  }

  //============================================================================
  //! REFRESH UI
  //============================================================================

  void _refresh() {
    setState(() {});
  }

  //============================================================================
  //! SHOW RESULTS
  //============================================================================

  void _showResults() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsScreen(
          filter: _filter.copyWith(query: _searchController.text),
          boardingHouses: const [],
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
            //============================================================================
            //! HEADER
            //============================================================================
            SearchHeader(onBackPressed: widget.onBackPressed),

            //============================================================================
            //! FILTERS
            //============================================================================
            Expanded(
              child: SearchFiltersBody(
                controller: _searchController,
                filter: _filter,
                onReset: _resetFilters,
                onChanged: _refresh,
              ),
            ),

            //============================================================================
            //! SHOW RESULTS BUTTON
            //============================================================================
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 46),
              child: CustomButton(
                text: 'Show Results',
                onPressed: _showResults,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
