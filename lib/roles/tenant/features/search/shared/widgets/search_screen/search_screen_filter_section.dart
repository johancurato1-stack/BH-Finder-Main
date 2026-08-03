import 'package:flutter/material.dart';

import 'search_screen_filter_section_title.dart';

//============================================================================
//! SEARCH SCREEN FILTER SECTION
//============================================================================

class SearchScreenFilterSection extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SearchScreenFilterSection({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  //============================================================================
  //! VARIABLES
  //============================================================================

  final String title;

  final Widget child;

  final Widget? trailing;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        //======================================================================
        //! SECTION HEADER
        //======================================================================
        SearchScreenFilterSectionTitle(title: title, trailing: trailing),

        //======================================================================
        //! SECTION CONTENT
        //======================================================================
        child,
      ],
    );
  }
}
