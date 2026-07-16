import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/features/search/models/search_filter_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/cards/bh_card_vertical.dart';
import 'package:bh_finder/features/search/widgets/search_results_header.dart';
import 'package:bh_finder/features/search/widgets/search_results_summary.dart';
import 'package:bh_finder/features/search/widgets/empty_search_results.dart';

class SearchResultsScreen extends StatelessWidget {
  final SearchFilterModel filter;
  final List<BoardingHouseModel> boardingHouses;

  const SearchResultsScreen({
    super.key,
    required this.filter,
    this.boardingHouses = const [],
  });

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
            //============================================================================
            //! HEADER
            //============================================================================
            const SearchResultsHeader(),

            //============================================================================
            //! SUMMARY
            //============================================================================
            SearchResultsSummary(
              filter: filter,
              resultCount: boardingHouses.length,
            ),

            const SizedBox(height: 10),

            //============================================================================
            //! RESULTS
            //============================================================================
            Expanded(
              child: boardingHouses.isEmpty
                  ? const EmptySearchResults()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),

                      itemCount: boardingHouses.length,

                      itemBuilder: (context, index) {
                        return BhCardVertical(
                          boardingHouse: boardingHouses[index],
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
