import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import '../../../../../shared/widgets/buttons/primary_button.dart';
import 'filter_button.dart';
import 'filter_constants.dart';
import 'filter_models.dart';

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
                _buildSectionTitle('Budget Range'),

                _buildFilterOptions(
                  FilterConstants.budgets,
                  _selectedBudget,
                  (value) => setState(() => _selectedBudget = value),
                ),

                //==============================================================
                //! AMENITIES
                //==============================================================
                _buildSectionTitle('Amenities'),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,

                  children: FilterConstants.amenities.map((
                    AmenityFilter amenity,
                  ) {
                    final label = amenity.label;
                    final isSelected = _selectedAmenities.contains(label);

                    return FilterButton(
                      label: label,
                      icon: amenity.icon,
                      isSelected: isSelected,

                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedAmenities.remove(label);
                          } else {
                            _selectedAmenities.add(label);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),

                //==============================================================
                //! DISTANCE
                //==============================================================
                _buildSectionTitle('Distance from School'),

                _buildFilterOptions(
                  FilterConstants.distances,
                  _selectedDistance,
                  (value) => setState(() => _selectedDistance = value),
                ),

                //==============================================================
                //! GENDER
                //==============================================================
                _buildSectionTitle('Gender Preference'),

                _buildFilterOptions(
                  FilterConstants.genders,
                  _selectedGender,
                  (value) => setState(() => _selectedGender = value),
                ),

                //==============================================================
                //! STATUS
                //==============================================================
                _buildSectionTitle('Room Status'),

                Wrap(
                  spacing: 5,
                  runSpacing: 5,

                  children: FilterConstants.statuses.map((StatusFilter status) {
                    final isSelected = _selectedStatus == status.label;

                    return FilterButton(
                      label: status.label,
                      isSelected: isSelected,
                      isStatusType: true,
                      statusColor: status.color,

                      onTap: () {
                        setState(() {
                          _selectedStatus = status.label;
                        });
                      },
                    );
                  }).toList(),
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

  //============================================================================
  //! WIDGETS
  //============================================================================

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

  Widget _buildFilterOptions(
    List<String> options,
    String selectedValue,
    ValueChanged<String> onSelected,
  ) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,

      children: options.map((option) {
        return FilterButton(
          label: option,
          isSelected: selectedValue == option,
          onTap: () => onSelected(option),
        );
      }).toList(),
    );
  }
}
