import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! DATE INFO
//============================================================================

class DateInfo extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const DateInfo({super.key, required this.createdAt, required this.updatedAt});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final DateTime createdAt;

  final DateTime updatedAt;

  //============================================================================
  //! DATE FORMAT
  //============================================================================

  String _formatDate(DateTime date) {
    return DateFormat('MMMM d, yyyy').format(date);
  }

  //============================================================================
  //! UPDATED LABEL
  //============================================================================

  String get _updatedLabel {
    if (createdAt == updatedAt) {
      return 'Never Updated';
    }

    return _formatDate(updatedAt);
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //==============================================================
        //! CREATED
        //==============================================================
        _DateRow(
          icon: Icons.schedule_rounded,
          title: 'Created',
          value: _formatDate(createdAt),
        ),

        const SizedBox(height: 12),

        //==============================================================
        //! UPDATED
        //==============================================================
        _DateRow(
          icon: Icons.edit_calendar_rounded,
          title: 'Last Updated',
          value: _updatedLabel,
        ),
      ],
    );
  }
}

//============================================================================
//! DATE ROW
//============================================================================

class _DateRow extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const _DateRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final IconData icon;

  final String title;

  final String value;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.tertiary),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
              color: AppColors.secondary,
            ),
          ),
        ),

        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Roboto',
            color: AppColors.tertiary,
          ),
        ),
      ],
    );
  }
}
