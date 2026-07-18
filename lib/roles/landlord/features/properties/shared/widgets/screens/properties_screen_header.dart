import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_text_styles.dart';

class PropertiesScreenHeader extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertiesScreenHeader({super.key, required this.onBackPressed});

  final VoidCallback onBackPressed;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          //==========================================================================
          //! BACK BUTTON
          //==========================================================================
          IconButton(
            onPressed: onBackPressed,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),

          //==========================================================================
          //! TITLE
          //==========================================================================
          Text(
            'Properties',
            style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.w700),
          ),

          //==========================================================================
          //! SPACER
          //==========================================================================
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
