import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet_header.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet_options_wrap.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet_section_title.dart';
import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';

class FilterBottomSheetSecondary extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const FilterBottomSheetSecondary({super.key});

  //============================================================================
  //! SHOW
  //============================================================================

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const FilterBottomSheetSecondary(),
    );
  }

  @override
  State<FilterBottomSheetSecondary> createState() =>
      _FilterBottomSheetMiniState();
}

class _FilterBottomSheetMiniState extends State<FilterBottomSheetSecondary> {
  //============================================================================
  //! STATE
  //============================================================================

  String _selectedBudget = 'Any';
  String _selectedGender = 'Any';

  final List<String> _budgets = ['Any', 'Lowest - Highest', 'Highest - Lowest'];

  final List<String> _genders = ['Male', 'Female', 'Any'];

  //============================================================================
  //! METHODS
  //============================================================================

  void _resetFilters() {
    setState(() {
      _selectedBudget = 'Any';
      _selectedGender = 'Any';
    });
  }

  void _applyFilters() {
    Navigator.pop(context);
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * .85,
      ),

      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //==========================================================================
          //! DRAG HANDLE
          //==========================================================================
          const SizedBox(height: 14),

          Container(
            width: 50,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          //==========================================================================
          //! HEADER
          //==========================================================================
          FilterBottomSheetHeader(onReset: _resetFilters),

          //==========================================================================
          //! FILTER CONTENT
          //==========================================================================
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              children: [
                //==============================================================
                //! BUDGET
                //==============================================================
                const FilterBottomSheetSectionTitle(title: 'Budget Range'),

                FilterBottomSheetOptionsWrap(
                  options: _budgets,
                  selectedValue: _selectedBudget,
                  onSelected: (value) {
                    setState(() => _selectedBudget = value);
                  },
                ),

                //==============================================================
                //! GENDER
                //==============================================================
                const FilterBottomSheetSectionTitle(title: 'Gender Preference'),

                FilterBottomSheetOptionsWrap(
                  options: _genders,
                  selectedValue: _selectedGender,
                  onSelected: (value) {
                    setState(() => _selectedGender = value);
                  },
                ),
              ],
            ),
          ),

          //==========================================================================
          //! APPLY BUTTON
          //==========================================================================
          Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              20,
              20,
              MediaQuery.of(context).padding.bottom + 20,
            ),
            child: PrimaryButton(
              text: 'Apply Filters',
              onPressed: _applyFilters,
            ),
          ),
        ],
      ),
    );
  }
}
