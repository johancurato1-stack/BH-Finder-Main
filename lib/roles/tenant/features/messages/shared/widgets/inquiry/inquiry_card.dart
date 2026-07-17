import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/roles/tenant/features/messages/models/inquiry_model.dart';
import 'package:bh_finder/roles/tenant/features/messages/models/message_model.dart';

class InquiryCard extends StatelessWidget {
  //============================================================================
  //! VARIABLES
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

        child: Column(
          crossAxisAlignment: message.isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,

          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 300),

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
                    Center(
                      child: Text(
                        "INQUIRY",
                        style: TextStyle(
                          color: AppColors.tertiary,
                          fontSize: 11,
                          letterSpacing: 1.4,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    _buildInfoRow(
                      Icons.home_work_rounded,
                      inquiry.boardingHouseName,
                    ),

                    const SizedBox(height: 12),

                    _buildInfoRow(
                      Icons.meeting_room_rounded,
                      inquiry.roomName ?? "Room",
                    ),

                    const SizedBox(height: 12),

                    _buildInfoRow(Icons.payments_rounded, inquiry.price),

                    const SizedBox(height: 12),

                    _buildInfoRow(Icons.people_alt_rounded, inquiry.genderRule),

                    const SizedBox(height: 18),

                    _buildStatusChip(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 4),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.formattedTime,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.tertiary,
                  ),
                ),

                if (message.isMe) ...[
                  const SizedBox(width: 6),

                  Icon(
                    message.statusIcon,
                    size: 15,
                    color: message.statusColor,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  //============================================================================
  //! INFO ROW
  //============================================================================

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: AppColors.secondary, fontSize: 13),
          ),
        ),
      ],
    );
  }

  //============================================================================
  //! STATUS CHIP
  //============================================================================

  Widget _buildStatusChip() {
    Color color;
    String label;

    switch (inquiry.status) {
      case InquiryStatus.pending:
        color = Colors.orange;
        label = "Inquiry Pending";
        break;

      case InquiryStatus.accepted:
        color = Colors.green;
        label = "Inquiry Accepted";
        break;

      case InquiryStatus.rejected:
        color = Colors.red;
        label = "Inquiry Rejected";
        break;

      case InquiryStatus.reserved:
        color = Colors.blue;
        label = "Inquiry Reserved";
        break;

      case InquiryStatus.completed:
        color = Colors.purple;
        label = "Inquiry Completed";
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(30),
      ),

      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
