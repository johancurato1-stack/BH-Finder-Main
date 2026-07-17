import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/core/providers/boarding_house_provider.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/widgets/property_detail_bottom_button.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/widgets/property_detail_floating_actions.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/widgets/property_detail_header.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/shared/widgets/image_carousel.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/widgets/property_detail_meta_row.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/widgets/property_detail_owner_card.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/shared/widgets/section_title.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/widgets/property_detail_amenities_grid.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/view_rooms_screen/view_rooms_screen.dart';

class PropertyDetailScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyDetailScreen({super.key, required this.boardingHouse});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final BoardingHouseModel boardingHouse;

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  //============================================================================
  //! STATE
  //============================================================================

  late final PageController _pageController;

  late final List<String> _images;

  Timer? _autoScrollTimer;

  int _currentPage = 0;

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _images = [
      widget.boardingHouse.imageUrl,
      'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?q=80&w=600',
      'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?q=80&w=600',
    ];

    _startAutoScroll();
  }

  //============================================================================
  //! METHODS
  //============================================================================

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) return;

      int nextPage = _currentPage + 1;

      if (nextPage >= _images.length) {
        nextPage = 0;
      }

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _viewRooms() {
    final provider = Provider.of<BoardingHouseProvider>(context, listen: false);

    final filteredRooms = provider.getRoomsForBh(widget.boardingHouse.id);

    debugPrint(
      'BH ID: ${widget.boardingHouse.id} | '
      'Found Rooms: ${filteredRooms.length}',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ViewRoomsScreen(
          bhName: widget.boardingHouse.title,
          rooms: filteredRooms,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();

    super.dispose();
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final bh = widget.boardingHouse;

    return Scaffold(
      backgroundColor: AppColors.background,

      body: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),

        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Stack(
                    children: [
                      ImageCarousel(
                        pageController: _pageController,
                        images: _images,
                        onPageChanged: (index) {
                          setState(() => _currentPage = index);
                        },
                      ),

                      PropertyFloatingActions(
                        boardingHouse: bh,
                        onBack: () => Navigator.pop(context),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PropertyHeader(boardingHouse: bh),

                        const SizedBox(height: 15),

                        PropertyMetaRow(boardingHouse: bh),

                        const Divider(
                          height: 32,
                          thickness: .5,
                          color: AppColors.tertiary,
                        ),

                        //======================================================
                        //! ABOUT
                        //======================================================
                        const SectionTitle(title: 'About this place'),

                        const SizedBox(height: 8),

                        Text(
                          bh.description,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.secondary,
                            height: 1.4,
                          ),
                        ),

                        const Divider(
                          height: 32,
                          thickness: .5,
                          color: AppColors.tertiary,
                        ),

                        //======================================================
                        //! AMENITIES
                        //======================================================
                        const SectionTitle(title: 'Amenities'),

                        const SizedBox(height: 12),

                        PropertyAmenitiesGrid(amenities: bh.amenities),

                        const Divider(
                          height: 32,
                          thickness: .5,
                          color: AppColors.tertiary,
                        ),

                        //======================================================
                        //! OWNER
                        //======================================================
                        const SectionTitle(title: 'Contact the owner'),

                        const SizedBox(height: 12),

                        PropertyOwnerCard(landlord: bh.landlord),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            PropertyBottomButton(
              roomCount: bh.totalRooms,
              onPressed: _viewRooms,
            ),
          ],
        ),
      ),
    );
  }
}
