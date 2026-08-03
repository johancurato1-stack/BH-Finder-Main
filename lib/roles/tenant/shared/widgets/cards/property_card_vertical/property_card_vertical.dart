import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/repositories/favorite_repository.dart';

import 'package:bh_finder/core/repositories/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories/room_repository.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/widgets/property_card_footer.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/widgets/property_card_image.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/widgets/property_card_info.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/property_detail_screen.dart';

//============================================================================
//! PROPERTY CARD VERTICAL
//============================================================================

class PropertyCardVertical extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardVertical({
    super.key,
    required this.property,
    required this.repository,
    required this.roomRepository,
    required this.favoriteRepository,
    this.showAmenities = true,
  });

  //============================================================================
  //! VARIABLES
  //============================================================================

  final TenantPropertyCardData property;

  final PropertyRepository repository;

  final RoomRepository roomRepository;

  final FavoriteRepository favoriteRepository;

  final bool showAmenities;

  @override
  State<PropertyCardVertical> createState() => _PropertyCardVerticalState();
}

//============================================================================
//! STATE
//============================================================================

class _PropertyCardVerticalState extends State<PropertyCardVertical> {
  //============================================================================
  //! STATE
  //============================================================================

  bool _pressed = false;

  //============================================================================
  //! OPEN PROPERTY
  //============================================================================

  void _openProperty() {
    Navigator.push(
      context,

      PageRouteBuilder(
        pageBuilder: (_, __, ___) => PropertyDetailScreen(
          propertyId: widget.property.id,
          repository: widget.repository,
          roomRepository: widget.roomRepository,
          favoriteRepository: widget.favoriteRepository,
        ),

        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),

            child: child,
          );
        },
      ),
    );
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _pressed = true;
        });
      },

      onTapUp: (_) {
        setState(() {
          _pressed = false;
        });
      },

      onTapCancel: () {
        setState(() {
          _pressed = false;
        });
      },

      onTap: _openProperty,

      child: AnimatedScale(
        scale: _pressed ? .97 : 1,

        duration: const Duration(milliseconds: 120),

        curve: Curves.easeOutCubic,

        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

          decoration: BoxDecoration(
            color: AppColors.white,

            borderRadius: BorderRadius.circular(12),

            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: .08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          clipBehavior: Clip.antiAlias,

          child: SizedBox(
            height: 128,

            child: Row(
              children: [
                //==============================================================
                //! IMAGE
                //==============================================================
                PropertyCardImage(data: widget.property),

                //==============================================================
                //! INFORMATION
                //==============================================================
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        PropertyCardInfo(data: widget.property),

                        const Spacer(),

                        PropertyCardFooter(
                          data: widget.property,
                          showAmenities: widget.showAmenities,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
