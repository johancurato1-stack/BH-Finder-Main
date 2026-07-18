import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/room_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/shared/widgets/image_carousel.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/shared/widgets/section_title.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_room_detail_screen/widgets/room_detail_bottom_button.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_room_detail_screen/widgets/room_detail_floating_actions.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_room_detail_screen/widgets/room_detail_header.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_room_detail_screen/widgets/room_detail_meta_row.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_room_detail_screen/widgets/room_detail_photos_section.dart';
import 'package:bh_finder/shared/page_indicator.dart';

class RoomDetailScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomDetailScreen({super.key, required this.room});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final RoomModel room;

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  //============================================================================
  //! STATE
  //============================================================================

  late final PageController _pageController;

  Timer? _timer;

  late final List<String> _images;

  int _currentPage = 0;

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _images = [
      'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&q=80&w=600',
      'https://images.unsplash.com/photo-1505691938895-1758d7feb511?q=80&w=600',
      'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=600',
    ];

    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) return;

      int nextPage = (_pageController.page?.toInt() ?? 0) + 1;

      if (nextPage >= _images.length) {
        nextPage = 0;
      }

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();

    super.dispose();
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  @override
  Widget build(BuildContext context) {
    final room = widget.room;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .40,
                  child: Stack(
                    children: [
                      ImageCarousel(
                        pageController: _pageController,
                        images: _images,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                      ),

                      RoomFloatingActions(
                        onBack: () => Navigator.pop(context),
                        onShare: () {},
                      ),
                    ],
                  ),
                ),

                PageIndicator(
                  currentPage: _currentPage,
                  pageCount: _images.length,
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoomHeader(room: room),

                      const SizedBox(height: 15),

                      RoomMetaRow(room: room),

                      const Divider(
                        height: 32,
                        thickness: .5,
                        color: AppColors.tertiary,
                      ),

                      //========================================================
                      //! ROOM PHOTOS
                      //========================================================
                      RoomPhotosSection(onViewAll: () {}),

                      const Divider(
                        height: 32,
                        thickness: .5,
                        color: AppColors.tertiary,
                      ),

                      //========================================================
                      //! DESCRIPTION
                      //========================================================
                      const SectionTitle(title: 'Description'),

                      const SizedBox(height: 8),

                      Text(
                        room.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.secondary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          RoomBottomCTA(
            onPressed: () {
              // TODO: Implement inquiry action.
            },
          ),
        ],
      ),
    );
  }
}
