import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/room_repository.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/view_models/room_detail_data.dart';

import 'package:bh_finder/shared/widgets/others/image_carousel.dart';
import 'package:bh_finder/shared/widgets/others/section_title.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/widgets/room_detail_bottom_button.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/widgets/room_detail_floating_actions.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/widgets/room_detail_header.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/widgets/room_detail_meta_row.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/widgets/room_detail_photos_section.dart';

import 'package:bh_finder/shared/widgets/others/page_indicator.dart';

//============================================================================
//! ROOM DETAIL SCREEN
//============================================================================

class RoomDetailScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomDetailScreen({
    super.key,
    required this.roomId,
    required this.repository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String roomId;

  final RoomRepository repository;

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  //============================================================================
  //! STATE
  //============================================================================

  RoomDetailData? _data;

  bool _loading = true;

  late final PageController _pageController;

  Timer? _timer;

  List<String> _images = [];

  int _currentPage = 0;
  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _loadRoom();
  }

  //============================================================================
  //! LOAD ROOM
  //============================================================================

  Future<void> _loadRoom() async {
    final data = await widget.repository.getRoomDetail(widget.roomId);

    if (!mounted) return;

    setState(() {
      _data = data;

      _images = data.imageUrls;

      _loading = false;
    });

    _startImageTimer();
  }

  //============================================================================
  //! IMAGE TIMER
  //============================================================================

  void _startImageTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) return;

      if (_images.isEmpty) return;

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
    if (_loading || _data == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,

        body: Center(child: CircularProgressIndicator()),
      );
    }

    final data = _data!;
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

                      RoomDetailFloatingActions(
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
                      RoomDetailHeader(data: data),

                      const SizedBox(height: 15),

                      RoomDetailMetaRow(data: data),

                      const Divider(
                        height: 32,

                        thickness: .5,

                        color: AppColors.tertiary,
                      ),

                      //========================================================
                      //! ROOM PHOTOS
                      //========================================================
                      RoomDetailPhotosSection(onViewAll: () {}),

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
                        data.description,

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

          RoomDetailBottomButton(
            onPressed: () {
              // TODO: Implement inquiry action.
            },
          ),
        ],
      ),
    );
  }
}
