import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/widgets/room_card_vertical.dart';
import 'package:bh_finder/core/data/mock_room.dart';
import 'package:bh_finder/widgets/filter_bottom_sheet.dart';

class SavedScreen extends StatefulWidget {
  final VoidCallback onBackPressed;

  const SavedScreen({super.key, required this.onBackPressed});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    final savedRooms = mockRooms.where((room) => room.isSaved).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          //!======================================================================================================================================== H E A D E R
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                //* Back icon
                children: [
                  IconButton(
                    onPressed: widget.onBackPressed,
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.secondary,
                      size: 24,
                    ),
                  ),

                  //* Page Title
                  const Text(
                    'Saved',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary,
                      fontFamily: 'Roboto',
                    ),
                  ),

                  //* Filter Icon
                  IconButton(
                    onPressed: () {
                      FilterBottomSheet.show(context);
                    },
                    icon: const Icon(
                      Icons.tune_rounded,
                      color: AppColors.primary,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),

            //!======================================================================================================================================== S A V E D  L I S T
            Expanded(
              child: savedRooms.isEmpty
                  ? const Center(
                      child: Text(
                        'No saved boarding houses yet.',
                        style: TextStyle(
                          color: AppColors.tertiary,
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemCount: savedRooms.length,
                      itemBuilder: (context, index) {
                        final room = savedRooms[index];
                        return RoomCardVertical(
                          title: room.title,
                          amenities: room.amenities,
                          imageUrl: room.imageUrl,
                          price: room.price,
                          distanceText: room.distanceText,
                          genderRules: room.genderRules,
                          availabilityCount: room.availabilityCount,
                          status: room.status,
                          rating: room.rating,
                          reviewCount: room.reviewCount,
                          isSaved: room.isSaved,
                          onHeartPressed: () {
                            setState(() {
                              room.isSaved = false;
                            });
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
