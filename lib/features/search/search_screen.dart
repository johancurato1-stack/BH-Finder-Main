import 'package:bh_finder/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/widgets/filter_button.dart';
import 'package:bh_finder/features/search/search_results_screen.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback onBackPressed;

  const SearchScreen({super.key, required this.onBackPressed});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  //* State Trackers
  String _selectedBudget = 'Any';
  final List<String> _selectedAmenities = [];
  String _selectedDistance = 'Any';
  String _selectedGender = 'Mixed';
  String _selectedStatus = 'Available';

  //* Config Lists
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            //!======================================================================================================================================== H E A D E R
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                //* Back Icon
                children: [
                  IconButton(
                    onPressed: widget.onBackPressed,
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.secondary,
                      size: 24,
                    ),
                  ),

                  //* Title
                  const Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),

                //!======================================================================================================================================== S E A R C H  B A R

                //* Search Bar
                children: [
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: AppColors.tertiary.withOpacity(0.3),
                        width: 0.5,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: AppColors.tertiary,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText:
                                  'Search boarding houses, schools, areas...',
                              hintStyle: TextStyle(
                                color: AppColors.tertiary,
                                fontSize: 12,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //!======================================================================================================================================== F I L T E R S
                  Padding(
                    padding: const EdgeInsets.only(top: 22, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Budget Range',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _searchController.clear();
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
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //* Budget Section
                  _buildStaticGrid(
                    _budgets,
                    _selectedBudget,
                    (val) => setState(() => _selectedBudget = val),
                  ),

                  //* Amenities Section
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

                  //* Distance Section
                  _buildSectionTitle('Distance from School'),
                  _buildStaticGrid(
                    _distances,
                    _selectedDistance,
                    (val) => setState(() => _selectedDistance = val),
                  ),

                  //* Gender Section
                  _buildSectionTitle('Gender Preference'),
                  _buildStaticGrid(
                    _genders,
                    _selectedGender,
                    (val) => setState(() => _selectedGender = val),
                  ),

                  //* Room Status Section
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
                  const SizedBox(height: 12),
                ],
              ),
            ),

            //!======================================================================================================================================== A P P L Y  B U T T O N
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 46),
              child: CustomButton(
                text: 'Show Results',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultsScreen(
                        searchQuery: _searchController.text,
                        budget: _selectedBudget,
                        amenities: _selectedAmenities,
                        distance: _selectedDistance,
                        gender: _selectedGender,
                        status: _selectedStatus,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 10),
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
