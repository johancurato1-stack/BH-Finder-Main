import 'package:flutter/material.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_buttons/filter_button.dart';

class SearchScreenStatusGrid extends StatelessWidget {
  final List<Map<String, dynamic>> statuses;
  final String selectedStatus;
  final ValueChanged<String> onSelected;

  const SearchScreenStatusGrid({
    super.key,
    required this.statuses,
    required this.selectedStatus,
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
      children: statuses.map((status) {
        return FilterButton(
          label: status['label'] as String,
          isStatusType: true,
          statusColor: status['color'] as Color?,
          isSelected: selectedStatus == status['label'],
          onTap: () => onSelected(status['label'] as String),
        );
      }).toList(),
    );
  }
}
