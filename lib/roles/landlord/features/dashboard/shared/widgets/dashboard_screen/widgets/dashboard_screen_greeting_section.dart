import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

//============================================================================
//! DASHBOARD SCREEN GREETING SECTION
//============================================================================

class DashboardScreenGreetingSection extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const DashboardScreenGreetingSection({
    super.key,
    required this.firstName,
    this.avatarUrl,
  });

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final String firstName;

  final String? avatarUrl;

  static const UserVerificationStatus _verificationStatus =
      UserVerificationStatus.unverified;

  //==========================================================================
  //! HELPERS
  //==========================================================================

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning';
    }

    if (hour < 18) {
      return 'Good afternoon';
    }

    return 'Good evening';
  }

  //==========================================================================
  //! VERIFICATION COLOR
  //==========================================================================

  Color _verificationColor(UserVerificationStatus status) {
    switch (status) {
      case UserVerificationStatus.verified:
        return Colors.green;

      case UserVerificationStatus.pending:
        return Colors.amber;

      case UserVerificationStatus.unverified:
        return Colors.red;
    }
  }

  IconData _verificationIcon(UserVerificationStatus status) {
    switch (status) {
      case UserVerificationStatus.verified:
        return Icons.check;

      case UserVerificationStatus.pending:
        return Icons.hourglass_top_rounded;

      case UserVerificationStatus.unverified:
        return Icons.close;
    }
  }

  //==========================================================================
  //! VERIFICATION BADGE
  //==========================================================================

  Widget _buildVerificationBadge() {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: _verificationColor(_verificationStatus),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.background, width: 2),
      ),
      child: Icon(
        _verificationIcon(_verificationStatus),
        size: 10,
        color: Colors.white,
      ),
    );
  }

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    final hasAvatar = avatarUrl != null && avatarUrl!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Row(
        children: [
          //==============================================================
          //! GREETING
          //==============================================================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${_getGreeting()},', style: AppTextStyles.subtitle),

                const SizedBox(height: AppSpacing.xs),

                Row(
                  children: [
                    Flexible(
                      child: Text(
                        firstName,
                        style: AppTextStyles.heading2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(width: 6),

                    const WaveEmoji(),
                  ],
                ),
              ],
            ),
          ),

          //==============================================================
          //! PROFILE
          //==============================================================
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: const Color(0xFFF3F4F6),
                backgroundImage: hasAvatar ? NetworkImage(avatarUrl!) : null,
                child: hasAvatar
                    ? null
                    : const Icon(
                        Icons.person_rounded,
                        size: 36,
                        color: Color(0xFF9CA3AF),
                      ),
              ),

              Positioned(
                right: -2,
                bottom: -2,
                child: _buildVerificationBadge(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//============================================================================
//! WAVE EMOJI
//============================================================================

class WaveEmoji extends StatefulWidget {
  const WaveEmoji({super.key});

  @override
  State<WaveEmoji> createState() => _WaveEmojiState();
}

class _WaveEmojiState extends State<WaveEmoji>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _playWave();
  }

  Future<void> _playWave() async {
    if (!mounted) return;

    await _controller.forward();

    if (!mounted) return;

    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;

    _controller.reset();

    _playWave();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _rotation(double value) {
    if (value < .20) return 20 * value;
    if (value < .40) return 4 - (value - .20) * 40;
    if (value < .60) return -4 + (value - .40) * 40;
    if (value < .80) return 4 - (value - .60) * 40;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform.rotate(
          angle: _rotation(_controller.value) * math.pi / 180,
          alignment: Alignment.bottomLeft,
          child: const Text('👋', style: TextStyle(fontSize: 24)),
        );
      },
    );
  }
}
