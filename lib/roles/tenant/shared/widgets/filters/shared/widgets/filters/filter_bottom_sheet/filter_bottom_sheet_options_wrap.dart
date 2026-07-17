import 'package:flutter/material.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_buttons/filter_button.dart';

class FilterOptionsWrap extends StatelessWidget {
  final List<String> options;
  final String selectedValue;
  final ValueChanged<String> onSelected;

  const FilterOptionsWrap({
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
          isSelected: selectedValue == option,
          onTap: () => onSelected(option),
        );
      }).toList(),
    );
  }
}
