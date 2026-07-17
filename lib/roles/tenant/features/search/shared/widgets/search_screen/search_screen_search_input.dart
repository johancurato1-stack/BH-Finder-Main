import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class SearchScreenSearchInput extends StatelessWidget {
  final TextEditingController controller;

  const SearchScreenSearchInput({super.key, required this.controller});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(25),

        border: Border.all(
          color: AppColors.tertiary.withOpacity(0.3),
          width: 0.5,
        ),
      ),

      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: Row(
        children: [
          //============================================================================
          //! SEARCH ICON
          //============================================================================
          const Icon(Icons.search, color: AppColors.tertiary, size: 22),

          const SizedBox(width: 10),

          //============================================================================
          //! SEARCH TEXT FIELD
          //============================================================================
          Expanded(
            child: TextField(
              controller: controller,

              decoration: const InputDecoration(
                hintText: 'Search boarding houses, schools, areas...',
                hintStyle: TextStyle(color: AppColors.tertiary, fontSize: 12),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
