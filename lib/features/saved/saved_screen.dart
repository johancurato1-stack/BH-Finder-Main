import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import '../../../shared/widgets/bh_card_vertical.dart';
import 'package:bh_finder/core/provider/bh_provider.dart';
import '../../shared/widgets/filter/filter_bottom_sheet.dart';
import 'package:bh_finder/shared/widgets/screens/bh_detail_screen.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatelessWidget {
  final VoidCallback onBackPressed;

  const SavedScreen({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: onBackPressed,
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.secondary,
                      size: 24,
                    ),
                  ),
                  const Text(
                    'Saved',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  IconButton(
                    onPressed: () => FilterBottomSheet.show(context),
                    icon: const Icon(
                      Icons.tune_rounded,
                      color: AppColors.primary,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),

            //! SAVED LIST
            Expanded(
              child: Consumer<BhProvider>(
                builder: (context, provider, child) {
                  final savedRooms = provider.savedRooms;

                  return savedRooms.isEmpty
                      ? const Center(
                          child: Text(
                            'No saved boarding houses yet.',
                            style: TextStyle(
                              color: AppColors.tertiary,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          itemCount: savedRooms.length,
                          itemBuilder: (context, index) {
                            final room = savedRooms[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BhDetailScreen(boardingHouse: room),
                                  ),
                                );
                              },
                              child: BhCardVertical(boardingHouse: room),
                            );
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
