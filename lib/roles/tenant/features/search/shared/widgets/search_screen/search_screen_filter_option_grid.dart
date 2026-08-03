import 'package:flutter/material.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_buttons/filter_button.dart';

//============================================================================
//! SEARCH SCREEN FILTER OPTION GRID
//============================================================================

class SearchScreenFilterOptionGrid extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SearchScreenFilterOptionGrid({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  });

  //============================================================================
  //! VARIABLES
  //============================================================================

  final List<String> options;

  final String selectedValue;

  final ValueChanged<String> onSelected;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,

      children: List.generate(options.length, (index) {
        final option = options[index];

        return FilterButton(
          label: option,
          isSelected: option == selectedValue,
          onTap: () => onSelected(option),
        );
      }),
    );
  }
}
