import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/models/landlord_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/utils/last_seen_formatter.dart';

//============================================================================
//! PROPERTY DETAIL OWNER CARD
//============================================================================

class PropertyDetailOwnerCard extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyDetailOwnerCard({super.key, required this.landlord});

  //============================================================================
  //! VARIABLES
  //============================================================================

  final LandlordModel landlord;

  //============================================================================
  //! COPY PHONE NUMBER
  //============================================================================

  Future<void> _copyPhoneNumber(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: landlord.phoneNumber));

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Phone number copied to clipboard.')),
    );
  }

  //============================================================================
  //! VERIFICATION BADGE
  //============================================================================

  Widget _buildVerificationBadge() {
    final isVerified =
        landlord.verificationStatus == VerificationStatus.approved;

    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: isVerified ? Colors.green : Colors.red,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.background, width: 2),
      ),
      child: Icon(
        isVerified ? Icons.check : Icons.close,
        size: 10,
        color: Colors.white,
      ),
    );
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final hasAvatar = landlord.profileImageUrl.trim().isNotEmpty;

    final lastSeenText = LastSeenFormatter.format(landlord.lastSeenAt);

    final isOnline = LastSeenFormatter.isOnline(landlord.lastSeenAt);

    return Row(
      children: [
        //==============================================================
        //! AVATAR
        //==============================================================
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.white,
              backgroundImage: hasAvatar
                  ? NetworkImage(landlord.profileImageUrl)
                  : null,
              child: !hasAvatar
                  ? const Icon(
                      Icons.person,
                      size: 28,
                      color: AppColors.tertiary,
                    )
                  : null,
            ),

            //----------------------------------------------------------
            //! VERIFICATION BADGE
            //----------------------------------------------------------
            Positioned(right: -2, bottom: -2, child: _buildVerificationBadge()),
          ],
        ),

        const SizedBox(width: 12),

        //==============================================================
        //! LANDLORD INFO
        //==============================================================
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //----------------------------------------------------------
              //! NAME
              //----------------------------------------------------------
              Text(
                landlord.fullName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                  color: AppColors.secondary,
                ),
              ),

              const SizedBox(height: 4),

              //----------------------------------------------------------
              //! ACTIVITY STATUS
              //----------------------------------------------------------
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 8,
                    color: isOnline ? Colors.green : Colors.grey,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    lastSeenText,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      color: AppColors.tertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        //==============================================================
        //! PHONE BUTTON
        //==============================================================
        IconButton(
          onPressed: () => _copyPhoneNumber(context),
          icon: const Icon(Icons.phone_rounded, color: AppColors.primary),
        ),
      ],
    );
  }
}
