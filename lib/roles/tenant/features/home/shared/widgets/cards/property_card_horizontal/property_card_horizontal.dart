import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/view_models/property_card_data.dart';

import 'package:bh_finder/roles/tenant/features/home/shared/widgets/cards/property_card_horizontal/widgets/property_card_horizontal_image.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/cards/property_card_horizontal/widgets/property_card_horizontal_info.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/property_detail_screen.dart';

//============================================================================
//! PROPERTY CARD HORIZONTAL
//============================================================================

class PropertyCardHorizontal extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardHorizontal({super.key, required this.data});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final PropertyCardData data;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //========================================================================
      //! NAVIGATE TO PROPERTY DETAILS
      //========================================================================
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                PropertyDetailScreen(propertyId: data.id),
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
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //==============================================================
            //! IMAGE
            //==============================================================
            PropertyCardHorizontalImage(data: data),

            //==============================================================
            //! INFORMATION
            //==============================================================
            PropertyCardHorizontalInfo(data: data),
          ],
        ),
      ),
    );
  }
}
