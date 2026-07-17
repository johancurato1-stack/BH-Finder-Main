import 'package:flutter/material.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_buttons/filter_button.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/constants/filter_constants.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/models/filters/filter_model.dart';

class StatusSection extends StatelessWidget {
  final String selectedStatus;
  final ValueChanged<String> onStatusSelected;

  const StatusSection({
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

      children: FilterConstants.statuses.map((StatusFilter status) {
        final isSelected = selectedStatus == status.label;

        return FilterButton(
          label: status.label,
          isSelected: isSelected,
          isStatusType: true,
          statusColor: status.color,
          onTap: () => onStatusSelected(status.label),
        );
      }).toList(),
    );
  }
}
