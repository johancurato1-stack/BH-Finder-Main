import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'filter_button.dart';
import '../custom_button.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // * State Trackers (Matching your exact SearchScreen defaults)
  String _selectedBudget = 'Any';
  final List<String> _selectedAmenities = [];
  String _selectedDistance = 'Any';
  String _selectedGender = 'Mixed';
  String _selectedStatus = 'Available';

  // * Config Lists (Directly mapped from your SearchScreen)
  final List<String> _budgets = [
    'Any',
    '₱1,500 - ₱3,000',
    '₱3,000 - ₱5,000',
    '₱5,000+',
  ];

  final List<Map<String, dynamic>> _amenities = [
    {'label': 'Wi-Fi', 'icon': Icons.wifi},
    {'label': 'Aircon', 'icon': Icons.ac_unit},
    {'label': 'Own CR', 'icon': Icons.bathroom},
    {'label': 'Parking', 'icon': Icons.local_parking},
    {'label': 'Laundry', 'icon': Icons.local_laundry_service},
    {'label': 'Kitchen', 'icon': Icons.countertops},
    {'label': 'Study Area', 'icon': Icons.menu_book},
    {'label': 'CCTV', 'icon': Icons.videocam},
  ];

  final List<String> _distances = [
    'Any',
    'Within 5 min walk',
    'Within 10 min walk',
    'Within 15 min walk',
  ];

  final List<String> _genders = ['Male', 'Female', 'Mixed'];

  final List<Map<String, dynamic>> _statuses = [
    {'label': 'Available', 'color': Colors.green},
    {'label': 'Occupied', 'color': Colors.red},
    {'label': 'Pending', 'color': Colors.amber},
  ];

  @override
  Widget build(BuildContext context) {
    // Draggable/scrollable height management wrapper
    return Container(
      constraints: BoxConstraints(
        maxHeight:
            MediaQuery.of(context).size.height *
            0.85, // Limits sheet from covering status bar
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
          // Drag Handle Pill
          const SizedBox(height: 14),
          Container(
            width: 50,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header Element Row
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
                  onPressed: () {
                    setState(() {
                      _selectedBudget = 'Any';
                      _selectedDistance = 'Any';
                      _selectedGender = 'Mixed';
                      _selectedStatus = 'Available';
                      _selectedAmenities.clear();
                    });
                  },
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

          // Scrollable Context Form
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              children: [
                // 1. Budget Range Section (Wrapped)
                _buildSectionTitle('Budget Range'),
                _buildStaticGrid(
                  _budgets,
                  _selectedBudget,
                  (val) => setState(() => _selectedBudget = val),
                ),

                // 2. Amenities Section (Wrapped with Icons!)
                _buildSectionTitle('Amenities'),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _amenities.map((amenity) {
                    final label = amenity['label'] as String;
                    final isSelected = _selectedAmenities.contains(label);
                    return FilterButton(
                      label: label,
                      icon: amenity['icon'] as IconData,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          isSelected
                              ? _selectedAmenities.remove(label)
                              : _selectedAmenities.add(label);
                        });
                      },
                    );
                  }).toList(),
                ),

                // 3. Distance Section (Wrapped)
                _buildSectionTitle('Distance from School'),
                _buildStaticGrid(
                  _distances,
                  _selectedDistance,
                  (val) => setState(() => _selectedDistance = val),
                ),

                // 4. Gender Preference Section (Wrapped: Male, Female, Mixed)
                _buildSectionTitle('Gender Preference'),
                _buildStaticGrid(
                  _genders,
                  _selectedGender,
                  (val) => setState(() => _selectedGender = val),
                ),

                // 5. Room Status Section (Wrapped with Status Colored Dots!)
                _buildSectionTitle('Room Status'),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _statuses.map((status) {
                    final isSelected = _selectedStatus == status['label'];
                    return FilterButton(
                      label: status['label'],
                      isSelected: isSelected,
                      isStatusType: true,
                      statusColor: status['color'],
                      onTap: () =>
                          setState(() => _selectedStatus = status['label']),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Sticky Core Bottom Button
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).padding.bottom + 78,
            ),
            child: CustomButton(
              text: 'Apply Filters',
              onPressed: () {
                // Closes panel downwards and can pass back choices if needed later
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
