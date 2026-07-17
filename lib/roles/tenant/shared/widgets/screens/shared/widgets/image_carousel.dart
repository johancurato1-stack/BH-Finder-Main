import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ImageCarousel({
    super.key,
    required this.pageController,
    required this.images,
    required this.onPageChanged,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final PageController pageController;
  final List<String> images;
  final ValueChanged<int> onPageChanged;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .40,
      child: PageView.builder(
        controller: pageController,
        itemCount: images.length,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          return Image.network(images[index], fit: BoxFit.cover);
        },
      ),
    );
  }
}
