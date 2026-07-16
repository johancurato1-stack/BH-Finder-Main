import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/widgets/add_boarding_house_card.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/widgets/boarding_house_card.dart';

class BoardingHouseCarousel extends StatefulWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const BoardingHouseCarousel({
    super.key,
    required this.boardingHouses,
    required this.onPageChanged,
    required this.onPropertyTap,
    required this.onAddProperty,
  });

  //==========================================================================
  //! VARIABLES
  //==========================================================================

  final List<BoardingHouseModel> boardingHouses;

  final ValueChanged<int> onPageChanged;

  final ValueChanged<BoardingHouseModel> onPropertyTap;

  final VoidCallback onAddProperty;

  @override
  State<BoardingHouseCarousel> createState() => _BoardingHouseCarouselState();
}

class _BoardingHouseCarouselState extends State<BoardingHouseCarousel> {
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

      final totalPages = widget.boardingHouses.length + 1;

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

        itemCount: widget.boardingHouses.length + 1,

        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });

          widget.onPageChanged(index);
        },

        itemBuilder: (context, index) {
          //==============================================================
          //! ADD BOARDING HOUSE CARD
          //==============================================================

          if (index == widget.boardingHouses.length) {
            return AddBoardingHouseCard(onTap: widget.onAddProperty);
          }

          //==============================================================
          //! BOARDING HOUSE CARD
          //==============================================================

          final boardingHouse = widget.boardingHouses[index];

          return BoardingHouseCard(
            boardingHouse: boardingHouse,

            onTap: () {
              widget.onPropertyTap(boardingHouse);
            },
          );
        },
      ),
    );
  }
}
