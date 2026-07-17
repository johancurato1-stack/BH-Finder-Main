import 'package:flutter/material.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_buttons/filter_button.dart';

class SearchScreenFilterOptionGrid extends StatelessWidget {
  final List<String> options;
  final String selectedValue;
  final ValueChanged<String> onSelected;

  const SearchScreenFilterOptionGrid({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  });

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,

      children: options.map((option) {
        return FilterButton(
          label: option,
          isSelected: option == selectedValue,
          onTap: () => onSelected(option),
        );
      }).toList(),
    );
  }
}
