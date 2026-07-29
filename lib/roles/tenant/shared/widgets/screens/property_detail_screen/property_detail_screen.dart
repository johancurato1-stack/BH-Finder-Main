import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';
import 'package:bh_finder/core/models/image_model.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/view_models/property_detail_data.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/widgets/property_detail_amenities_grid.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/widgets/property_detail_bottom_button.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/widgets/property_detail_floating_actions.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/widgets/property_detail_header.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/widgets/property_detail_meta_row.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/widgets/property_detail_owner_card.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/view_rooms_screen/view_rooms_screen.dart';

import 'package:bh_finder/shared/widgets/others/image_carousel.dart';
import 'package:bh_finder/shared/widgets/others/section_title.dart';
import 'package:bh_finder/shared/widgets/others/page_indicator.dart';

//============================================================================
//! PROPERTY DETAIL SCREEN
//============================================================================

class PropertyDetailScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyDetailScreen({
    super.key,
    required this.propertyId,
    required this.repository,
    required this.roomRepository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String propertyId;

  final PropertyRepository repository;

  final RoomRepository roomRepository;

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}
//============================================================================
//! STATE
//============================================================================

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  //============================================================================
  //! STATE
  //============================================================================

  PropertyDetailData? _data;

  bool _loading = true;

  late final PageController _pageController;

  List<ImageModel> _images = [];

  Timer? _autoScrollTimer;

  int _currentPage = 0;

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _loadProperty();
  }

  //============================================================================
  //! LOAD PROPERTY
  //============================================================================

  Future<void> _loadProperty() async {
    try {
      final data = await widget.repository.getPropertyDetail(widget.propertyId);

      if (!mounted) return;

      setState(() {
        _data = data;

        _images = data.images;

        _loading = false;
      });

      _startAutoScroll();
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();

    _pageController.dispose();

    super.dispose();
  }

  //============================================================================
  //! METHODS
  //============================================================================

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) return;

      if (_images.isEmpty) return;

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

  void _viewRooms(PropertyDetailData data) {
    Navigator.push(
      context,

      MaterialPageRoute(
        builder: (_) => ViewRoomsScreen(
          PropertyName: data.title,

          rooms: data.rooms,

          repository: widget.roomRepository,
        ),
      ),
    );
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

                        images: _images.map((image) => image.path).toList(),

                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                      ),

                      PropertyDetailFloatingActions(
                        onBack: () => Navigator.pop(context),

                        isFavorite: false,

                        onFavorite: () {
                          // TODO:
                          // Connect FavoritesRepository
                        },
                      ),
                    ],
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
                        PropertyDetailHeader(data: data),

                        const SizedBox(height: 15),

                        PropertyDetailMetaRow(data: data),

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
                          data.description,

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

                        PropertyDetailAmenitiesGrid(amenities: data.amenities),

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

                        if (data.landlord != null)
                          PropertyDetailOwnerCard(landlord: data.landlord!),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            PropertyDetailBottomButton(
              roomCount: data.roomCount,

              onPressed: () {
                _viewRooms(data);
              },
            ),
          ],
        ),
      ),
    );
  }
}
