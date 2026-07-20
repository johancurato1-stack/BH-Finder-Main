import 'package:flutter/material.dart';

import 'package:bh_finder/core/view_models/tenant_property_card_data.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/widgets/property_card_amenities.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/widgets/property_card_footer.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/widgets/property_card_image.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/widgets/property_card_info.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/property_detail_screen.dart';

//============================================================================
//! PROPERTY CARD VERTICAL
//============================================================================

class PropertyCardVertical extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardVertical({super.key, required this.property});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final TenantPropertyCardData property;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                PropertyDetailScreen(propertyId: property.id),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0, 1);
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
            //==========================================================================
            //! IMAGE
            //==========================================================================
            PropertyCardImage(data: property),

            const SizedBox(width: 12),

            //==========================================================================
            //! CONTENT
            //==========================================================================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PropertyCardInfo(
                    data: property,
                    onFavoritePressed: () {
                      // TODO: Toggle favorite
                    },
                  ),

                  const SizedBox(height: 6),

                  PropertyAmenities(data: property),

                  const SizedBox(height: 18),

                  PropertyCardFooter(data: property),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
