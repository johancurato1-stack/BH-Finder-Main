import 'package:flutter/material.dart';

class AvailabilityNoticeCard extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const AvailabilityNoticeCard({super.key});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEBEBFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD1D1E9), width: .5),
      ),
      child: Row(
        children: const [
          SizedBox(width: 16),

          Icon(Icons.info, color: Color(0xFF4B4B9A), size: 20),

          SizedBox(width: 50),

          Expanded(
            child: Text(
              "Availability changes fast.\n"
              "Inquire now to get the latest update from the owner",
              style: TextStyle(
                color: Color(0xFF4B4B9A),
                fontSize: 13,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
