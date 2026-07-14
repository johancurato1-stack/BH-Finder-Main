import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/shared/widgets/filter/filter_button.dart';
import 'package:bh_finder/shared/widgets/custom_button.dart';

class FilterBottomSheet2 extends StatefulWidget {
  const FilterBottomSheet2({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet2(),
    );
  }

  @override
  State<FilterBottomSheet2> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet2> {
  // State variables - using String for single selection
  String _selectedBudget = 'Any';
  String _selectedGender = 'Any';

  final List<String> _budgets = ['Any', 'Lowest - Highest', 'Highest - Lowest'];

  final List<String> _genders = ['Male', 'Female', 'Any'];

  void _resetFilters() {
    setState(() {
      _selectedBudget = 'Any';
      _selectedGender = 'Any';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
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
          // Drag Handle
          const SizedBox(height: 14),
          Container(
            width: 50,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Listings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondary,
                    fontFamily: 'Roboto',
                  ),
                ),
                TextButton(
                  onPressed: _resetFilters,
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              children: [
                _buildSectionTitle('Budget Range'),
                _buildStaticGrid(
                  _budgets,
                  _selectedBudget,
                  (val) => setState(() => _selectedBudget = val),
                ),
                _buildSectionTitle('Gender Preference'),
                _buildStaticGrid(
                  _genders,
                  _selectedGender,
                  (val) => setState(() => _selectedGender = val),
                ),
              ],
            ),
          ),

          // Apply Button
          Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              20,
              20,
              MediaQuery.of(context).padding.bottom + 20,
            ),
            child: CustomButton(
              text: 'Apply Filters',
              onPressed: () {
                // Pass back selected values if needed here
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.secondary,
        ),
      ),
    );
  }

  Widget _buildStaticGrid(
    List<String> options,
    String selectedValue,
    Function(String) onSelect,
  ) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        return FilterButton(
          label: option,
          isSelected: selectedValue == option,
          onTap: () => onSelect(option),
        );
      }).toList(),
    );
  }
}
