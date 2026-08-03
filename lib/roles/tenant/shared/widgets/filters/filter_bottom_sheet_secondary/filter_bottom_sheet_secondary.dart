import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/room_search_filter_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet_header.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet_options_wrap.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet_section_title.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';

//============================================================================
//! FILTER BOTTOM SHEET SECONDARY
//============================================================================

class FilterBottomSheetSecondary extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const FilterBottomSheetSecondary({super.key, required this.initialFilter});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final RoomSearchFilterModel initialFilter;

  //============================================================================
  //! SHOW
  //============================================================================

  static Future<RoomSearchFilterModel?> show(
    BuildContext context, {
    required RoomSearchFilterModel initialFilter,
  }) {
    return showModalBottomSheet<RoomSearchFilterModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheetSecondary(initialFilter: initialFilter),
    );
  }

  @override
  State<FilterBottomSheetSecondary> createState() =>
      _FilterBottomSheetSecondaryState();
}

class _FilterBottomSheetSecondaryState
    extends State<FilterBottomSheetSecondary> {
  //============================================================================
  //! STATE
  //============================================================================

  late String _selectedPrice;

  late String _selectedGender;

  //============================================================================
  //! OPTIONS
  //============================================================================

  final List<String> _priceOptions = [
    'Any',
    'Lowest to Highest',
    'Highest to Lowest',
  ];

  final List<String> _genderOptions = ['Any', 'Male', 'Female'];

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _selectedPrice = widget.initialFilter.sortPrice;
    _selectedGender = widget.initialFilter.gender;
  }

  //============================================================================
  //! RESET
  //============================================================================

  void _reset() {
    setState(() {
      _selectedPrice = 'Any';
      _selectedGender = 'Any';
    });
  }

  //============================================================================
  //! APPLY
  //============================================================================

  void _apply() {
    Navigator.pop(
      context,
      RoomSearchFilterModel(sortPrice: _selectedPrice, gender: _selectedGender),
    );
  }

  //============================================================================
  //! FILTER SECTION
  //============================================================================

  Widget _buildFilterSection({
    required String title,
    required List<String> options,
    required String selectedValue,
    required ValueChanged<String> onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterBottomSheetSectionTitle(title: title),

        FilterBottomSheetOptionsWrap(
          options: options,
          selectedValue: selectedValue,
          onSelected: onSelected,
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      constraints: BoxConstraints(maxHeight: mediaQuery.size.height * .85),

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
          //==============================================================
          //! DRAG HANDLE
          //==============================================================
          const SizedBox(height: 14),

          Container(
            width: 50,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          //==============================================================
          //! HEADER
          //==============================================================
          FilterBottomSheetHeader(onReset: _reset),

          //==============================================================
          //! FILTER CONTENT
          //==============================================================
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),

              children: [
                _buildFilterSection(
                  title: 'Price',
                  options: _priceOptions,
                  selectedValue: _selectedPrice,
                  onSelected: (value) {
                    setState(() => _selectedPrice = value);
                  },
                ),

                _buildFilterSection(
                  title: 'Gender Preference',
                  options: _genderOptions,
                  selectedValue: _selectedGender,
                  onSelected: (value) {
                    setState(() => _selectedGender = value);
                  },
                ),
              ],
            ),
          ),

          //==============================================================
          //! APPLY BUTTON
          //==============================================================
          Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              20,
              20,
              mediaQuery.padding.bottom + 78,
            ),

            child: PrimaryButton(text: 'Apply Filters', onPressed: _apply),
          ),
        ],
      ),
    );
  }
}
