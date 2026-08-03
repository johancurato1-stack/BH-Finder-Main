import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/models/search_filter_model.dart';

import 'package:bh_finder/shared/widgets/animations/animated_entrance.dart';

//============================================================================
//! SEARCH RESULTS SCREEN SUMMARY
//============================================================================

class SearchResultsScreenSummary extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SearchResultsScreenSummary({
    super.key,
    required this.filter,
    required this.resultCount,
  });

  //============================================================================
  //! VARIABLES
  //============================================================================

  final SearchFilterModel filter;

  final int resultCount;

  //============================================================================
  //! TEXT STYLES
  //============================================================================

  static const TextStyle _summaryStyle = TextStyle(
    fontSize: 14,
    height: 1.4,
    color: AppColors.tertiary,
    fontFamily: 'Roboto',
  );

  static const TextStyle _countStyle = TextStyle(
    fontSize: 14,
    color: AppColors.tertiary,
    fontFamily: 'Roboto',
  );

  //============================================================================
  //! HELPERS
  //============================================================================

  String get _resultText {
    if (resultCount == 0) {
      return 'No properties found';
    }

    return '$resultCount propert${resultCount == 1 ? 'y' : 'ies'} found';
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return AnimatedEntrance(
      order: 0,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            //==============================================================
            //! FILTER SUMMARY
            //==============================================================
            if (filter.hasActiveFilters) ...[
              Text(filter.buildSummary(), style: _summaryStyle),

              const SizedBox(height: 12),
            ],

            //==============================================================
            //! RESULT COUNT
            //==============================================================
            Text(_resultText, style: _countStyle),
          ],
        ),
      ),
    );
  }
}
