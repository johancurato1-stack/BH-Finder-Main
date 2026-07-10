import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class SearchResultsScreen extends StatefulWidget {
  final String searchQuery;
  final String budget;
  final List<String> amenities;
  final String distance;
  final String gender;
  final String status;
  final List<dynamic> discoveredPlaces;

  const SearchResultsScreen({
    super.key,
    required this.searchQuery,
    required this.budget,
    required this.amenities,
    required this.distance,
    required this.gender,
    required this.status,
    this.discoveredPlaces = const [], //* Total Rooms
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  String _buildFilterString() {
    final List<String> parts = [];

    if (widget.searchQuery.trim().isNotEmpty) {
      parts.add(widget.searchQuery.trim());
    }

    if (widget.budget != 'Any') {
      parts.add(widget.budget);
    }

    if (widget.amenities.isNotEmpty) {
      parts.addAll(widget.amenities);
    }

    if (widget.distance != 'Any') {
      parts.add(widget.distance);
    }

    parts.add(widget.gender);

    parts.add(widget.status);

    return parts.join(' - ');
  }

  @override
  Widget build(BuildContext context) {
    final filterText = _buildFilterString();
    final int count = widget.discoveredPlaces.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //!======================================================================================================================================== T O P  H E A D E R
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.secondary,
                      size: 24,
                    ),
                  ),
                  const Text(
                    'Results',
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

            //!======================================================================================================================================== F I L T E R  S U M M A R Y
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (filterText.isNotEmpty)
                    Text(
                      filterText,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.tertiary,
                        height: 1.4,
                      ),
                    ),
                  const SizedBox(height: 12),

                  Text(
                    count == 0 ? 'No rooms found' : '$count places found',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.tertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            //!======================================================================================================================================== L I S T
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  // Cards will map out here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
