import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import '../../../../../../shared/widgets/buttons/primary_button.dart';

import '../shared/constants/filter_constants.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/filter_bottom_sheet/widgets/filter_bottom_sheet_amenities_section.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet_header.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet_options_wrap.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet_section_title.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/filter_bottom_sheet/widgets/filter_bottom_sheet_status_section.dart';

class FilterBottomSheet extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const FilterBottomSheet({super.key});

  //============================================================================
  //! SHOW
  //============================================================================

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const FilterBottomSheet(),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  //============================================================================
  //! STATE
  //============================================================================

  String _selectedBudget = 'Any';
  final List<String> _selectedAmenities = [];

  String _selectedDistance = 'Any';
  String _selectedGender = 'Mixed';
  String _selectedStatus = 'Available';

  //============================================================================
  //! METHODS
  //============================================================================

  void _resetFilters() {
    setState(() {
      _selectedBudget = 'Any';
      _selectedDistance = 'Any';
      _selectedGender = 'Mixed';
      _selectedStatus = 'Available';
      _selectedAmenities.clear();
    });
  }

  void _toggleAmenity(String amenity) {
    setState(() {
      if (_selectedAmenities.contains(amenity)) {
        _selectedAmenities.remove(amenity);
      } else {
        _selectedAmenities.add(amenity);
      }
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
                const FilterSectionTitle(title: 'Budget Range'),

                FilterOptionsWrap(
                  options: FilterConstants.budgets,
                  selectedValue: _selectedBudget,
                  onSelected: (value) {
                    setState(() => _selectedBudget = value);
                  },
                ),

                //==============================================================
                //! AMENITIES
                //==============================================================
                const FilterSectionTitle(title: 'Amenities'),

                AmenitiesSection(
                  selectedAmenities: _selectedAmenities,
                  onAmenityToggle: _toggleAmenity,
                ),

                //==============================================================
                //! DISTANCE
                //==============================================================
                const FilterSectionTitle(title: 'Distance from School'),

                FilterOptionsWrap(
                  options: FilterConstants.distances,
                  selectedValue: _selectedDistance,
                  onSelected: (value) {
                    setState(() => _selectedDistance = value);
                  },
                ),

                //==============================================================
                //! GENDER
                //==============================================================
                const FilterSectionTitle(title: 'Gender Preference'),

                FilterOptionsWrap(
                  options: FilterConstants.genders,
                  selectedValue: _selectedGender,
                  onSelected: (value) {
                    setState(() => _selectedGender = value);
                  },
                ),

                //==============================================================
                //! STATUS
                //==============================================================
                const FilterSectionTitle(title: 'Room Status'),

                StatusSection(
                  selectedStatus: _selectedStatus,
                  onStatusSelected: (status) {
                    setState(() => _selectedStatus = status);
                  },
                ),
              ],
            ),
          ),

          //==========================================================================
          //! APPLY BUTTON
          //==========================================================================
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).padding.bottom + 78,
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
