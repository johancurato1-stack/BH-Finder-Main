import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! SEARCH SCREEN SEARCH INPUT
//============================================================================

class SearchScreenSearchInput extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SearchScreenSearchInput({super.key, required this.controller});

  //============================================================================
  //! VARIABLES
  //============================================================================

  final TextEditingController controller;

  //============================================================================
  //! INPUT DECORATION
  //============================================================================

  static const InputDecoration _inputDecoration = InputDecoration(
    hintText: 'Search boarding houses, schools, areas...',
    hintStyle: TextStyle(color: AppColors.tertiary, fontSize: 12),
    border: InputBorder.none,
  );

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,

      margin: const EdgeInsets.only(bottom: 10),

      padding: const EdgeInsets.symmetric(horizontal: 16),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(25),

        border: Border.all(
          color: AppColors.tertiary.withValues(alpha: .3),
          width: .5,
        ),
      ),

      child: Row(
        children: [
          //====================================================================
          //! SEARCH ICON
          //====================================================================
          const Icon(Icons.search, color: AppColors.tertiary, size: 22),

          const SizedBox(width: 10),

          //====================================================================
          //! SEARCH TEXT FIELD
          //====================================================================
          Expanded(
            child: TextField(
              controller: controller,

              decoration: _inputDecoration,
            ),
          ),
        ],
      ),
    );
  }
}
