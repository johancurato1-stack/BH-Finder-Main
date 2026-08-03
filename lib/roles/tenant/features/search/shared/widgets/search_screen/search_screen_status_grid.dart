import 'package:flutter/material.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_buttons/filter_button.dart';

//============================================================================
//! SEARCH SCREEN STATUS GRID
//============================================================================

class SearchScreenStatusGrid extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SearchScreenStatusGrid({
    super.key,
    required this.statuses,
    required this.selectedStatus,
    required this.onSelected,
  });

  //============================================================================
  //! VARIABLES
  //============================================================================

  final List<Map<String, dynamic>> statuses;

  final String selectedStatus;

  final ValueChanged<String> onSelected;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,

      children: List.generate(statuses.length, (index) {
        final status = statuses[index];

        final label = status['label'] as String;
        final color = status['color'] as Color?;

        return FilterButton(
          label: label,
          isStatusType: true,
          statusColor: color,
          isSelected: selectedStatus == label,
          onTap: () => onSelected(label),
        );
      }),
    );
  }
}
