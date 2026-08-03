import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! SEARCH SCREEN FILTER SECTION TITLE
//============================================================================

class SearchScreenFilterSectionTitle extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SearchScreenFilterSectionTitle({
    super.key,
    required this.title,
    this.trailing,
  });

  //============================================================================
  //! VARIABLES
  //============================================================================

  final String title;

  final Widget? trailing;

  //============================================================================
  //! TEXT STYLE
  //============================================================================

  static const TextStyle _titleStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
    color: AppColors.secondary,
  );

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 10),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          //====================================================================
          //! SECTION TITLE
          //====================================================================
          Text(title, style: _titleStyle),

          //====================================================================
          //! TRAILING
          //====================================================================
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
