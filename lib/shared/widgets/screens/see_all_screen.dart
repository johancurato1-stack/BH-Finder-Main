import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/data/models/bh_model.dart';
import 'package:bh_finder/core/provider/bh_provider.dart';
import 'package:bh_finder/shared/widgets/bh_card_vertical.dart';
import 'package:bh_finder/shared/widgets/screens/bh_detail_screen.dart';
import 'package:bh_finder/shared/widgets/filter/filter_bottom_sheet.dart';

class SeeAllScreen extends StatelessWidget {
  final String title;
  final List<BhModel> boardingHouses;

  const SeeAllScreen({
    super.key,
    required this.title,
    required this.boardingHouses,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            //! EXACT HEADER FROM SAVED SCREEN
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.secondary,
                      size: 24,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
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

            //! CONSUMER LIST (To make heart icon work)
            Expanded(
              child: Consumer<BhProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: boardingHouses.length,
                    itemBuilder: (context, index) {
                      final room = boardingHouses[index];
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
