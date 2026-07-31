import 'package:flutter/material.dart';

import 'package:bh_finder/roles/tenant/features/search/data/search_filter_options.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_buttons/filter_button.dart';

class FilterBottomSheetStatusSection extends StatelessWidget {
  final String selectedStatus;
  final ValueChanged<String> onStatusSelected;

  const FilterBottomSheetStatusSection({
    super.key,
    required this.selectedStatus,
    required this.onStatusSelected,
  });

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: SearchFilterOptions.statuses.map((status) {
        final label = status['label'] as String;
        final color = status['color'] as Color?;

        return FilterButton(
          label: label,
          isSelected: selectedStatus == label,
          isStatusType: true,
          statusColor: color,
          onTap: () => onStatusSelected(label),
        );
      }).toList(),
    );
  }
}
