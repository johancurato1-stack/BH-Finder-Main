import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/property_repository.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/view_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/features/search/models/search_filter_model.dart';

import 'package:bh_finder/roles/tenant/features/search/shared/widgets/search_screen/search_screen_header.dart';
import 'package:bh_finder/roles/tenant/features/search/shared/widgets/search_screen/search_screen_filters_body.dart';

import 'package:bh_finder/roles/tenant/features/search/screens/search_results_screen.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';

//============================================================================
//! SEARCH SCREEN
//============================================================================

class SearchScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SearchScreen({super.key, required this.onBackPressed});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onBackPressed;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //============================================================================
  //! DEPENDENCIES
  //============================================================================

  final PropertyRepository _propertyRepository = PropertyRepository();

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
    final List<TenantPropertyCardData> properties = _propertyRepository
        .getPropertyCards();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsScreen(
          filter: _filter.copyWith(query: _searchController.text),
          properties: properties,
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
            //==========================================================================
            //! HEADER
            //==========================================================================
            SearchScreenHeader(onBackPressed: widget.onBackPressed),

            //==========================================================================
            //! FILTERS
            //==========================================================================
            Expanded(
              child: SearchScreenFilterBody(
                controller: _searchController,
                filter: _filter,
                onReset: _resetFilters,
                onChanged: _refresh,
              ),
            ),

            //==========================================================================
            //! SHOW RESULTS BUTTON
            //==========================================================================
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 46),
              child: PrimaryButton(
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
