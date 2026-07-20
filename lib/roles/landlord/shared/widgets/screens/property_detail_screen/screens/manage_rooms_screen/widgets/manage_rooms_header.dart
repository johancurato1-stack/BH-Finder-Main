import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class ManageRoomsHeader extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ManageRoomsHeader({
    super.key,
    required this.title,
    required this.onBack,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String title;
  final VoidCallback onBack;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          //====================================================================
          //! BACK BUTTON
          //====================================================================
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.secondary,
            iconSize: 24,
          ),

          //====================================================================
          //! TITLE
          //====================================================================
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          //====================================================================
          //! ADD ROOM
          //====================================================================
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add Room coming soon!')),
              );
            },
            icon: const Icon(Icons.add_rounded),
            color: AppColors.primary,
            iconSize: 26,
          ),
        ],
      ),
    );
  }
}
