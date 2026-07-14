import 'package:flutter/material.dart';

import 'package:bh_finder/features/search/models/search_filter_model.dart';
import 'package:bh_finder/features/search/data/search_filter_options.dart';

import 'search_input.dart';
import 'filter_section.dart';
import 'filter_option_grid.dart';
import 'amenities_grid.dart';
import 'status_grid.dart';

class SearchFiltersBody extends StatelessWidget {
  final TextEditingController controller;
  final SearchFilterModel filter;

  final VoidCallback onReset;
  final VoidCallback onChanged;

  const SearchFiltersBody({
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
        SearchInput(controller: controller),

        //============================================================================
        //! BUDGET
        //============================================================================
        FilterSection(
          title: 'Budget Range',

          trailing: GestureDetector(
            onTap: onReset,

            child: const Text(
              'Reset',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
                color: Colors.blue,
              ),
            ),
          ),

          child: FilterOptionGrid(
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
        FilterSection(
          title: 'Amenities',

          child: AmenitiesGrid(
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
        //! DISTANCE
        //============================================================================
        FilterSection(
          title: 'Distance from School',

          child: FilterOptionGrid(
            options: SearchFilterOptions.distances,
            selectedValue: filter.distance,

            onSelected: (value) {
              filter.distance = value;
              onChanged();
            },
          ),
        ),

        //============================================================================
        //! GENDER
        //============================================================================
        FilterSection(
          title: 'Gender Preference',

          child: FilterOptionGrid(
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
        FilterSection(
          title: 'Room Status',

          child: StatusGrid(
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
