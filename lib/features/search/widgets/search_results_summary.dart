import 'package:flutter/material.dart';

import 'package:bh_finder/features/search/models/search_filter_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class SearchResultsSummary extends StatelessWidget {
  final SearchFilterModel filter;
  final int resultCount;

  const SearchResultsSummary({
    super.key,
    required this.filter,
    required this.resultCount,
  });

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //============================================================================
          //! FILTER SUMMARY
          //============================================================================
          if (filter.hasActiveFilters)
            Text(
              filter.buildSummary(),
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.tertiary,
                height: 1.4,
              ),
            ),

          if (filter.hasActiveFilters) const SizedBox(height: 12),

          //============================================================================
          //! RESULT COUNT
          //============================================================================
          Text(
            resultCount == 0
                ? 'No places found'
                : '$resultCount place${resultCount == 1 ? '' : 's'} found',
            style: const TextStyle(fontSize: 14, color: AppColors.tertiary),
          ),
        ],
      ),
    );
  }
}
