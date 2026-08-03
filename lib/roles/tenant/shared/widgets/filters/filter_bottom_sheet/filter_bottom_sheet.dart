import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/options/search_filter_options.dart';
import 'package:bh_finder/core/models/search_filter_model.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/filter_bottom_sheet/widgets/filter_bottom_sheet_amenities_section.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/filter_bottom_sheet/widgets/filter_bottom_sheet_status_section.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet_header.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet_options_wrap.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet_section_title.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';

//============================================================================
//! FILTER BOTTOM SHEET
//============================================================================

class FilterBottomSheet extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const FilterBottomSheet({super.key, required this.initialFilter});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final SearchFilterModel initialFilter;

  //============================================================================
  //! SHOW
  //============================================================================

  static Future<SearchFilterModel?> show(
    BuildContext context, {
    required SearchFilterModel initialFilter,
  }) {
    return showModalBottomSheet<SearchFilterModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(initialFilter: initialFilter),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  //============================================================================
  //! STATE
  //============================================================================

  late SearchFilterModel _filter;

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _filter = widget.initialFilter.copyWith();
  }

  //============================================================================
  //! RESET
  //============================================================================

  void _reset() {
    setState(() {
      _filter.reset();
    });
  }

  //============================================================================
  //! TOGGLE AMENITY
  //============================================================================

  void _toggleAmenity(String amenity) {
    setState(() {
      if (_filter.amenities.contains(amenity)) {
        _filter.amenities.remove(amenity);
      } else {
        _filter.amenities.add(amenity);
      }
    });
  }

  //============================================================================
  //! APPLY
  //============================================================================

  void _apply() {
    Navigator.pop(context, _filter);
  }

  //============================================================================
  //! OPTION SECTION
  //============================================================================

  Widget _buildOptionSection({
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
                _buildOptionSection(
                  title: 'Budget Range',
                  options: SearchFilterOptions.budgets,
                  selectedValue: _filter.budget,
                  onSelected: (value) {
                    setState(() {
                      _filter.budget = value;
                    });
                  },
                ),

                const FilterBottomSheetSectionTitle(title: 'Amenities'),

                FilterBottomSheetAmenitiesSection(
                  selectedAmenities: _filter.amenities,
                  onAmenityToggle: _toggleAmenity,
                ),

                const SizedBox(height: 20),

                _buildOptionSection(
                  title: 'Gender Preference',
                  options: SearchFilterOptions.genders,
                  selectedValue: _filter.gender,
                  onSelected: (value) {
                    setState(() {
                      _filter.gender = value;
                    });
                  },
                ),

                const FilterBottomSheetSectionTitle(title: 'Property Status'),

                FilterBottomSheetStatusSection(
                  selectedStatus: _filter.status,
                  onStatusSelected: (status) {
                    setState(() {
                      _filter.status = status;
                    });
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
