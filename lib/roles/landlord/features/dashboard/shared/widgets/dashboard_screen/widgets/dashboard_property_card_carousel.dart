import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bh_finder/core/ui_models/landlord_property_card_data.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/cards/add_property_card_horizontal/add_property_card_horizontal.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/cards/property_card_horizontal/property_card_horizontal.dart';

//============================================================================
//! DASHBOARD PROPERTY CARD CAROUSEL
//============================================================================

class DashboardPropertyCardCarousel extends StatefulWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const DashboardPropertyCardCarousel({
    super.key,
    required this.properties,
    required this.onPageChanged,
    required this.onPropertyTap,
    required this.onAddProperty,
  });

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final List<LandlordPropertyCardData> properties;

  final ValueChanged<int> onPageChanged;

  final ValueChanged<LandlordPropertyCardData> onPropertyTap;

  final VoidCallback onAddProperty;

  @override
  State<DashboardPropertyCardCarousel> createState() =>
      _DashboardPropertyCardCarouselState();
}

//============================================================================
//! STATE
//============================================================================

class _DashboardPropertyCardCarouselState
    extends State<DashboardPropertyCardCarousel> {
  //==========================================================================
  //! CONTROLLERS
  //==========================================================================

  late final PageController _pageController;

  //==========================================================================
  //! STATE
  //==========================================================================

  int _currentPage = 0;

  bool _isUserInteracting = false;

  Timer? _autoScrollTimer;

  Timer? _resumeAutoScrollTimer;

  //==========================================================================
  //! LIFECYCLE
  //==========================================================================

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: .90);

    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _resumeAutoScrollTimer?.cancel();

    _pageController.dispose();

    super.dispose();
  }

  //==========================================================================
  //! AUTO SCROLL
  //==========================================================================

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) return;

      if (_isUserInteracting) return;

      final totalPages = widget.properties.length + 1;

      int nextPage = _currentPage + 1;

      if (nextPage >= totalPages) {
        nextPage = 0;
      }

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    });
  }

  //==========================================================================
  //! STOP AUTO SCROLL
  //==========================================================================

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
  }

  //==========================================================================
  //! RESUME AUTO SCROLL
  //==========================================================================

  void _scheduleAutoScrollResume() {
    _resumeAutoScrollTimer?.cancel();

    _resumeAutoScrollTimer = Timer(const Duration(seconds: 10), () {
      if (!mounted) return;

      _isUserInteracting = false;

      _startAutoScroll();
    });
  }

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 365,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            _isUserInteracting = true;

            _stopAutoScroll();
          }

          if (notification is ScrollEndNotification) {
            _scheduleAutoScrollResume();
          }

          return false;
        },
        child: PageView.builder(
          controller: _pageController,

          itemCount: widget.properties.length + 1,

          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });

            widget.onPageChanged(index);
          },

          itemBuilder: (context, index) {
            //==============================================================
            //! ADD PROPERTY CARD
            //==============================================================

            if (index == widget.properties.length) {
              return AddPropertyCardHorizontal(onTap: widget.onAddProperty);
            }

            //==============================================================
            //! PROPERTY CARD
            //==============================================================

            final property = widget.properties[index];

            return PropertyCardHorizontal(
              data: property,
              onTap: () => widget.onPropertyTap(property),
            );
          },
        ),
      ),
    );
  }
}
