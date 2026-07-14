import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/data/models/room_model.dart';
import 'package:bh_finder/shared/widgets/room_card.dart';
import 'package:bh_finder/shared/widgets/filter_button_2.dart';
import 'package:bh_finder/shared/widgets/filter_bottom_sheet_2.dart';
import 'package:bh_finder/shared/widgets/screens/room_detail_screen.dart';

class ViewRoomsScreen extends StatefulWidget {
  final String bhName;
  final List<RoomModel> rooms;

  const ViewRoomsScreen({super.key, required this.bhName, required this.rooms});

  @override
  State<ViewRoomsScreen> createState() => _ViewRoomsScreenState();
}

class _ViewRoomsScreenState extends State<ViewRoomsScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Available', 'Reserved', 'Occupied'];

  List<RoomModel> get _filteredRooms {
    if (_selectedFilter == 'All') return widget.rooms;
    return widget.rooms
        .where((r) => r.status.toLowerCase() == _selectedFilter.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: AppColors.secondary,
                    iconSize: 24,
                  ),
                  Expanded(
                    child: Text(
                      widget.bhName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => FilterBottomSheet2.show(context),
                    icon: const Icon(Icons.tune_rounded),
                    color: AppColors.primary,
                    iconSize: 26,
                  ),
                ],
              ),
            ),
            // Text-Only Filter Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: Row(
                children: _filters
                    .map(
                      (label) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterButton2(
                          label: label,
                          isSelected: _selectedFilter == label,
                          onTap: () => setState(() => _selectedFilter = label),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            // Room List
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: _filteredRooms.isEmpty
                        ? const Center(child: Text("No rooms available."))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _filteredRooms.length,
                            itemBuilder: (context, index) {
                              final room = _filteredRooms[index];
                              return RoomCard(
                                room: room,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RoomDetailScreen(room: room),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ),
                  // Bottom Sign
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBEBFA),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFD1D1E9),
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.info,
                          color: Color(0xFF4B4B9A),
                          size: 20,
                        ),
                        const SizedBox(width: 50),
                        const Expanded(
                          child: Text(
                            "Availability changes fast.\nInquire now to get the latest update from the owner",
                            style: TextStyle(
                              color: Color(0xFF4B4B9A),
                              fontSize: 13,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
