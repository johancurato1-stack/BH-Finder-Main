import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/widgets/property_card_amenities.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/widgets/property_card_footer.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/widgets/property_card_image.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/widgets/property_card_info.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/property_detail_screen.dart';

class PropertyCardVertical extends StatelessWidget {
  final BoardingHouseModel boardingHouse;

  const PropertyCardVertical({super.key, required this.boardingHouse});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Navigate to the boarding house details screen.
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                PropertyDetailScreen(boardingHouse: boardingHouse),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.easeOut;

                  final offsetAnimation = animation.drive(
                    Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: curve)),
                  );

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //============================================================================
            //! IMAGE SECTION
            //============================================================================
            PropertyCardImage(boardingHouse: boardingHouse),

            const SizedBox(width: 12),

            //============================================================================
            //! CARD CONTENT
            //============================================================================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PropertyCardInfo(boardingHouse: boardingHouse),

                  const SizedBox(height: 6),

                  //============================================================================
                  //! AMENITIES
                  //============================================================================
                  PropertyAmenities(boardingHouse: boardingHouse),

                  const SizedBox(height: 6),

                  //============================================================================
                  //! FOOTER
                  //============================================================================
                  PropertyCardFooter(boardingHouse: boardingHouse),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
