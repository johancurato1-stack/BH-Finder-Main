import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/inquiry_model.dart';
import 'package:bh_finder/core/models/message_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! INQUIRY CARD
//============================================================================

class InquiryCard extends StatelessWidget {
  //============================================================================
  //! FIELDS
  //============================================================================

  final InquiryModel inquiry;

  final MessageModel message;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const InquiryCard({super.key, required this.inquiry, required this.message});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),

        child: Container(
          constraints: const BoxConstraints(maxWidth: 340),

          decoration: BoxDecoration(
            color: AppColors.white,

            borderRadius: BorderRadius.circular(18),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),

          child: Padding(
            padding: const EdgeInsets.all(14),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                //================================================================
                //! TITLE
                //================================================================
                Center(
                  child: Text(
                    'INQUIRY',
                    style: const TextStyle(
                      color: AppColors.tertiary,
                      fontSize: 11,
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                //================================================================
                //! ROOM & PROPERTY
                //================================================================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    //============================================================
                    //! ROOM IMAGE
                    //============================================================
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),

                      child: SizedBox(
                        width: 92,
                        height: 92,

                        child: inquiry.roomImageUrl.isNotEmpty
                            ? Image.network(
                                inquiry.roomImageUrl,
                                fit: BoxFit.cover,

                                errorBuilder: (_, __, ___) {
                                  return _buildImagePlaceholder();
                                },

                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }

                                      return _buildImagePlaceholder();
                                    },
                              )
                            : _buildImagePlaceholder(),
                      ),
                    ),

                    const SizedBox(width: 12),

                    //============================================================
                    //! ROOM DETAILS
                    //============================================================
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          //======================================================
                          //! ROOM TITLE
                          //======================================================
                          Text(
                            inquiry.roomTitle,

                            maxLines: 2,

                            overflow: TextOverflow.ellipsis,

                            style: const TextStyle(
                              color: AppColors.secondary,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 4),

                          //======================================================
                          //! PROPERTY NAME
                          //======================================================
                          Text(
                            inquiry.propertyName,

                            maxLines: 2,

                            overflow: TextOverflow.ellipsis,

                            style: const TextStyle(
                              color: AppColors.tertiary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 12),

                          //======================================================
                          //! PRICE
                          //======================================================
                          Text(
                            '₱${inquiry.roomPrice.toStringAsFixed(0)} / month',

                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                //================================================================
                //! ROOM INFORMATION
                //================================================================
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 11,
                  ),

                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: .04),

                    borderRadius: BorderRadius.circular(12),

                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: .08),
                    ),
                  ),

                  child: Row(
                    children: [
                      //========================================================
                      //! CAPACITY
                      //========================================================
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.people_alt_rounded,
                              size: 18,
                              color: AppColors.primary,
                            ),

                            const SizedBox(width: 7),

                            Expanded(
                              child: Text(
                                'Capacity: ${inquiry.roomCapacity}',

                                overflow: TextOverflow.ellipsis,

                                style: const TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //========================================================
                      //! DIVIDER
                      //========================================================
                      Container(
                        width: 1,
                        height: 22,

                        color: AppColors.tertiary.withValues(alpha: .18),
                      ),

                      //========================================================
                      //! GENDER
                      //========================================================
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            const Icon(
                              Icons.wc_outlined,
                              size: 18,
                              color: AppColors.primary,
                            ),

                            const SizedBox(width: 7),

                            Flexible(
                              child: Text(
                                _formatGender(inquiry.roomGenderPreference),

                                overflow: TextOverflow.ellipsis,

                                style: const TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                //================================================================
                //! DIVIDER
                //================================================================
                Divider(
                  height: 1,

                  thickness: 1,

                  color: AppColors.tertiary.withValues(alpha: .12),
                ),

                const SizedBox(height: 14),

                //================================================================
                //! INQUIRY MESSAGE
                //================================================================
                Text(
                  inquiry.message,

                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //============================================================================
  //! IMAGE PLACEHOLDER
  //============================================================================

  Widget _buildImagePlaceholder() {
    return Container(
      color: AppColors.primary.withValues(alpha: .06),

      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 28,
          color: AppColors.primary.withValues(alpha: .45),
        ),
      ),
    );
  }

  //============================================================================
  //! FORMAT GENDER
  //============================================================================

  String _formatGender(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return 'Male only';

      case 'female':
        return 'Female only';

      case 'mixed':
        return 'Mixed';

      default:
        return gender;
    }
  }
}
