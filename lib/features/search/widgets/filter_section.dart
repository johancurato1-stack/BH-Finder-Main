import 'package:flutter/material.dart';

import 'filter_section_title.dart';

class FilterSection extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const FilterSection({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        //============================================================================
        //! SECTION HEADER
        //============================================================================
        FilterSectionTitle(title: title, trailing: trailing),

        //============================================================================
        //! SECTION CONTENT
        //============================================================================
        child,
      ],
    );
  }
}
