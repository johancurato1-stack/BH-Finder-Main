import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/view_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/features/search/models/search_filter_model.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/property_card_vertical.dart';
import 'package:bh_finder/roles/tenant/features/search/shared/widgets/search_results_screen/search_results_screen_header.dart';
import 'package:bh_finder/roles/tenant/features/search/shared/widgets/search_results_screen/search_results_screen_summary.dart';
import 'package:bh_finder/roles/tenant/features/search/shared/widgets/search_results_screen/empty_search_results_screen.dart';

//============================================================================
//! SEARCH RESULTS SCREEN
//============================================================================

class SearchResultsScreen extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SearchResultsScreen({
    super.key,
    required this.filter,
    this.properties = const [],
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final SearchFilterModel filter;

  final List<TenantPropertyCardData> properties;

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
              filter: filter,
              resultCount: properties.length,
            ),

            const SizedBox(height: 10),

            //==========================================================================
            //! RESULTS
            //==========================================================================
            Expanded(
              child: properties.isEmpty
                  ? const EmptySearchResultsScreen()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      itemCount: properties.length,
                      itemBuilder: (context, index) {
                        return PropertyCardVertical(
                          property: properties[index],
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
