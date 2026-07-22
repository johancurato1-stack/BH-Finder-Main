import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/shared/widgets/others/section_title.dart';

class RoomDetailPhotosSection extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomDetailPhotosSection({super.key, required this.onViewAll});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onViewAll;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //==========================================================================
        //! HEADER
        //==========================================================================
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionTitle(title: 'Room Photos'),

            TextButton(
              onPressed: onViewAll,
              child: const Text(
                'View All',
                style: TextStyle(
                  color: AppColors.primary,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 3),

        //==========================================================================
        //! THUMBNAILS
        //==========================================================================
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, __) {
              return Container(
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
