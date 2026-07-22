import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bh_finder/core/view_models/landlord_property_card_data.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/cards/add_property_card/add_property_card.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/cards/property_card_horizontal/property_card_horizontal.dart';

//============================================================================
//! BOARDING HOUSE CAROUSEL
//============================================================================

class PropertyCardCarousel extends StatefulWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyCardCarousel({
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
  State<PropertyCardCarousel> createState() => _BoardingHouseCarouselState();
}

class _BoardingHouseCarouselState extends State<PropertyCardCarousel> {
  //==========================================================================
  //! CONTROLLERS
  //==========================================================================

  late final PageController _pageController;

  //==========================================================================
  //! VARIABLES
  //==========================================================================

  int _currentPage = 0;

  Timer? _autoScrollTimer;

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
    _pageController.dispose();

    super.dispose();
  }

  //==========================================================================
  //! AUTO SCROLL
  //==========================================================================

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) return;

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
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 365,
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
            return AddPropertyCard(onTap: widget.onAddProperty);
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
    );
  }
}
