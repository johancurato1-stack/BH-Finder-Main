import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/features/search/models/search_filter_model.dart';
import 'package:bh_finder/roles/tenant/features/search/data/search_filter_options.dart';

import 'search_screen_search_input.dart';
import 'search_screen_filter_section.dart';
import 'search_screen_filter_option_grid.dart';
import 'search_screen_amenities_grid.dart';
import 'search_screen_status_grid.dart';

class SearchScreenFilterBody extends StatelessWidget {
  final TextEditingController controller;
  final SearchFilterModel filter;

  final VoidCallback onReset;
  final VoidCallback onChanged;

  const SearchScreenFilterBody({
    super.key,
    required this.controller,
    required this.filter,
    required this.onReset,
    required this.onChanged,
  });

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),

      children: [
        //============================================================================
        //! SEARCH INPUT
        //============================================================================
        SearchScreenSearchInput(controller: controller),

        //============================================================================
        //! BUDGET
        //============================================================================
        SearchScreenFilterSection(
          title: 'Budget Range',

          trailing: GestureDetector(
            onTap: onReset,

            child: const Text(
              'Reset',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
                color: AppColors.primary,
              ),
            ),
          ),

          child: SearchScreenFilterOptionGrid(
            options: SearchFilterOptions.budgets,
            selectedValue: filter.budget,

            onSelected: (value) {
              filter.budget = value;
              onChanged();
            },
          ),
        ),

        //============================================================================
        //! AMENITIES
        //============================================================================
        SearchScreenFilterSection(
          title: 'Amenities',

          child: SearchScreenAmenitiesGrid(
            amenities: SearchFilterOptions.amenities,
            selectedAmenities: filter.amenities,

            onToggle: (label) {
              if (filter.amenities.contains(label)) {
                filter.amenities.remove(label);
              } else {
                filter.amenities.add(label);
              }

              onChanged();
            },
          ),
        ),

        //============================================================================
        //! GENDER
        //============================================================================
        SearchScreenFilterSection(
          title: 'Gender Preference',

          child: SearchScreenFilterOptionGrid(
            options: SearchFilterOptions.genders,
            selectedValue: filter.gender,

            onSelected: (value) {
              filter.gender = value;
              onChanged();
            },
          ),
        ),

        //============================================================================
        //! STATUS
        //============================================================================
        SearchScreenFilterSection(
          title: 'Property Status',

          child: SearchScreenStatusGrid(
            statuses: SearchFilterOptions.statuses,
            selectedStatus: filter.status,

            onSelected: (value) {
              filter.status = value;
              onChanged();
            },
          ),
        ),
      ],
    );
  }
}
