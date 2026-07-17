import 'package:flutter/material.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_buttons/filter_button_2.dart';

class RoomStatusFilterBar extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomStatusFilterBar({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onSelected,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<String> filters;
  final String selectedFilter;
  final ValueChanged<String> onSelected;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      child: Row(
        children: filters
            .map(
              (label) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterButton2(
                  label: label,
                  isSelected: selectedFilter == label,
                  onTap: () => onSelected(label),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
