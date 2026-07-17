import 'package:flutter/material.dart';

import 'search_screen_filter_section_title.dart';

class SearchScreenFilterSection extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const SearchScreenFilterSection({
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
        SearchScreenFilterSectionTitle(title: title, trailing: trailing),

        //============================================================================
        //! SECTION CONTENT
        //============================================================================
        child,
      ],
    );
  }
}
