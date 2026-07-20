import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/room_repository.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/view_models/room_detail_data.dart';

import 'package:bh_finder/shared/widgets/image_carousel.dart';
import 'package:bh_finder/shared/widgets/section_title.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/widgets/room_detail_bottom_button.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/widgets/room_detail_floating_actions.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/widgets/room_detail_header.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/widgets/room_detail_meta_row.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/widgets/room_detail_photos_section.dart';
import 'package:bh_finder/shared/widgets/page_indicator.dart';

//============================================================================
//! ROOM DETAIL SCREEN
//============================================================================

class RoomDetailScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomDetailScreen({super.key, required this.roomId});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String roomId;

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  //============================================================================
  //! DEPENDENCIES
  //============================================================================

  final RoomRepository _repository = RoomRepository();

  //============================================================================
  //! STATE
  //============================================================================

  late final RoomDetailData _data;

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

    _data = _repository.getRoomDetail(widget.roomId);

    _pageController = PageController();

    _images = _data.imageUrls;

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
  Widget build(BuildContext context) {
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
                      RoomHeader(data: _data),

                      const SizedBox(height: 15),

                      RoomMetaRow(data: _data),

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
                        _data.description,
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
