import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/repositories/favorite_repository.dart';
import 'package:bh_finder/core/repositories/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories/room_repository.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/features/home/shared/widgets/cards/property_card_horizontal/widgets/property_card_horizontal_image.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/cards/property_card_horizontal/widgets/property_card_horizontal_info.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/property_detail_screen.dart';

//============================================================================
//! PROPERTY CARD HORIZONTAL
//============================================================================

class PropertyCardHorizontal extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardHorizontal({
    super.key,
    required this.data,
    required this.repository,
    required this.roomRepository,
    required this.favoriteRepository,
  });

  //============================================================================
  //! VARIABLES
  //============================================================================

  final TenantPropertyCardData data;

  final PropertyRepository repository;

  final RoomRepository roomRepository;

  final FavoriteRepository favoriteRepository;

  @override
  State<PropertyCardHorizontal> createState() => _PropertyCardHorizontalState();
}

class _PropertyCardHorizontalState extends State<PropertyCardHorizontal> {
  //============================================================================
  //! STATE
  //============================================================================

  bool _pressed = false;

  //============================================================================
  //! NAVIGATE TO PROPERTY DETAILS
  //============================================================================

  Future<void> _openPropertyDetails() async {
    setState(() {
      _pressed = true;
    });

    await Future.delayed(const Duration(milliseconds: 80));

    if (!mounted) {
      return;
    }

    setState(() {
      _pressed = false;
    });

    await Navigator.push(
      context,

      PageRouteBuilder(
        pageBuilder: (_, __, ___) => PropertyDetailScreen(
          propertyId: widget.data.id,
          repository: widget.repository,
          roomRepository: widget.roomRepository,
          favoriteRepository: widget.favoriteRepository,
        ),

        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0, 1);

          const end = Offset.zero;

          const curve = Curves.easeOutCubic;

          final offsetAnimation = animation.drive(
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve)),
          );

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOutCubic,
      scale: _pressed ? .97 : 1,

      child: Material(
        color: Colors.transparent,

        borderRadius: BorderRadius.circular(16),

        child: InkWell(
          borderRadius: BorderRadius.circular(16),

          splashColor: AppColors.primary.withValues(alpha: .08),

          highlightColor: Colors.transparent,

          onTap: _openPropertyDetails,

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),

            decoration: BoxDecoration(
              color: AppColors.white,

              borderRadius: BorderRadius.circular(16),

              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: .05),

                  blurRadius: 14,

                  offset: const Offset(0, 6),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                //==============================================================
                //! IMAGE
                //==============================================================
                PropertyCardHorizontalImage(data: widget.data),

                //==============================================================
                //! INFORMATION
                //==============================================================
                PropertyCardHorizontalInfo(data: widget.data),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
