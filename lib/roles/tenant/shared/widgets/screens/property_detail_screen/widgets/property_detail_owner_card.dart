import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/models/landlord_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! PROPERTY OWNER CARD
//============================================================================

class PropertyDetailOwnerCard extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyDetailOwnerCard({super.key, required this.landlord});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final LandlordModel landlord;

  //============================================================================
  //! RESPONSE TIME
  //============================================================================

  /// Returns a readable response time.
  String _getResponseTime(ResponseTime responseTime) {
    switch (responseTime) {
      case ResponseTime.within15Minutes:
        return 'Typically responds within 15 minutes';

      case ResponseTime.within30Minutes:
        return 'Typically responds within 30 minutes';

      case ResponseTime.within1Hour:
        return 'Typically responds within 1 hour';

      case ResponseTime.within3Hours:
        return 'Typically responds within 3 hours';

      case ResponseTime.within24Hours:
        return 'Typically responds within 24 hours';

      case ResponseTime.moreThan24Hours:
        return 'Typically responds in more than 24 hours';
    }
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(landlord.profileImageUrl),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                landlord.fullName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),

              Text(
                _getResponseTime(landlord.responseTime),
                style: const TextStyle(fontSize: 12, color: AppColors.tertiary),
              ),
            ],
          ),
        ),

        IconButton(
          icon: const Icon(Icons.phone, color: AppColors.primary),
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: landlord.phoneNumber));

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Phone number copied to clipboard.'),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
