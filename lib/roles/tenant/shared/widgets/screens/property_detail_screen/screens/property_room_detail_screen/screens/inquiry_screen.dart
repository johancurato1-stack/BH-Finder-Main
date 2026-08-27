import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';
import 'package:bh_finder/core/ui_models/room_detail_data.dart';

import 'package:bh_finder/core/view_models/chat_view_model.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';
import 'package:bh_finder/shared/widgets/textfields/primary_form_text_field.dart';

//============================================================================
//! INQUIRY SCREEN
//============================================================================

class InquiryScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const InquiryScreen({super.key, required this.data});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final RoomDetailData data;

  @override
  State<InquiryScreen> createState() => _InquiryScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _InquiryScreenState extends State<InquiryScreen> {
  //============================================================================
  //! CONTROLLER
  //============================================================================

  final TextEditingController _messageController = TextEditingController();

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void dispose() {
    _messageController.dispose();

    super.dispose();
  }

  //============================================================================
  //! SEND INQUIRY
  //============================================================================

  Future<void> _sendInquiry() async {
    final chatViewModel = context.read<ChatViewModel>();

    //==========================================================================
    //! SPAM PROTECTION
    //==========================================================================

    if (chatViewModel.isSending) {
      return;
    }

    //==========================================================================
    //! SEND
    //==========================================================================

    await chatViewModel.sendInquiry(
      landlordId: widget.data.landlordId,
      propertyId: widget.data.propertyId,
      roomId: widget.data.id,
      roomTitle: widget.data.title,
      roomPrice: widget.data.price,
      roomCapacity: widget.data.capacity,
      genderPreference: widget.data.genderPreference,
      message: _messageController.text,
    );

    if (!mounted) {
      return;
    }

    //==========================================================================
    //! ERROR
    //==========================================================================

    if (chatViewModel.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send inquiry: ${chatViewModel.error}'),
        ),
      );

      chatViewModel.clearError();

      return;
    }

    //==========================================================================
    //! SUCCESS
    //==========================================================================

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Inquiry sent successfully.')));

    Navigator.pop(context);
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            //==================================================================
            //! HEADER
            //==================================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

              child: Row(
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,

                    child: IconButton(
                      onPressed: () => Navigator.pop(context),

                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.secondary,
                        size: 24,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      'Send Inquiry',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading2.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  const SizedBox(width: 48),
                ],
              ),
            ),

            //==================================================================
            //! CONTENT
            //==================================================================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenPadding,
                  AppSpacing.md,
                  AppSpacing.screenPadding,
                  AppSpacing.lg,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    //==========================================================
                    //! PROPERTY DETAILS
                    //==========================================================
                    Text(
                      'Property Details',
                      style: AppTextStyles.heading3.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    _buildPropertyCard(data),

                    const SizedBox(height: 18),

                    //==========================================================
                    //! ROOM DETAILS
                    //==========================================================
                    Text(
                      'Room Details',
                      style: AppTextStyles.heading3.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    _buildRoomCard(data),

                    const SizedBox(height: 28),

                    //==========================================================
                    //! MESSAGE
                    //==========================================================
                    Text(
                      'Message',
                      style: AppTextStyles.heading3.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Message to the owner (optional).',
                      style: AppTextStyles.subtitle,
                    ),

                    const SizedBox(height: AppSpacing.md),

                    PrimaryFormField(
                      controller: _messageController,
                      hintText: 'Write a message...',
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
            ),

            //==================================================================
            //! SEND BUTTON
            //==================================================================
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.sm,
                AppSpacing.screenPadding,
                MediaQuery.of(context).padding.bottom + AppSpacing.sm,
              ),

              child: Consumer<ChatViewModel>(
                builder: (context, viewModel, _) {
                  return PrimaryButton(
                    text: viewModel.isSending ? 'Sending...' : 'Send Inquiry',

                    //================================================================
                    //! SPAM PROTECTION
                    //================================================================
                    onPressed: _sendInquiry,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //============================================================================
  //! PROPERTY CARD
  //============================================================================

  Widget _buildPropertyCard(RoomDetailData data) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(AppSpacing.md),

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.xl),

        border: Border.all(
          color: AppColors.tertiary.withValues(alpha: .20),
          width: .5,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          //====================================================================
          //! HERO IMAGE
          //====================================================================
          _buildHeroImage(imageUrl: data.propertyImageUrl, size: 62),

          const SizedBox(height: 12),

          //====================================================================
          //! PROPERTY TITLE
          //====================================================================
          Text(
            data.propertyTitle,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          //====================================================================
          //! LOCATION
          //====================================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: AppColors.secondary,
              ),

              const SizedBox(width: 6),

              Expanded(
                child: Text(
                  data.propertyAddress,
                  style: AppTextStyles.subtitle,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          //====================================================================
          //! OWNER
          //====================================================================
          Row(
            children: [
              const Icon(
                Icons.person_outline_rounded,
                size: 18,
                color: AppColors.secondary,
              ),

              const SizedBox(width: 6),

              Expanded(
                child: Text(
                  data.landlordName.isEmpty ? 'Owner' : data.landlordName,
                  style: AppTextStyles.subtitle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //============================================================================
  //! ROOM CARD
  //============================================================================

  Widget _buildRoomCard(RoomDetailData data) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(AppSpacing.md),

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.xl),

        border: Border.all(
          color: AppColors.tertiary.withValues(alpha: .20),
          width: .5,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          //====================================================================
          //! HERO IMAGE
          //====================================================================
          _buildHeroImage(
            imageUrl: data.images.isEmpty ? '' : data.images.first.path,
            size: 62,
          ),

          const SizedBox(height: 12),

          //====================================================================
          //! ROOM TITLE
          //====================================================================
          Text(
            data.title,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          //====================================================================
          //! ROOM INFORMATION
          //====================================================================
          Row(
            children: [
              _buildRoomInfo(
                icon: Icons.people_outline_rounded,
                text: '${data.capacity} person${data.capacity == 1 ? '' : 's'}',
              ),

              const SizedBox(width: 18),

              _buildRoomInfo(
                icon: Icons.wc_outlined,
                text: _formatGender(data.genderPreference),
              ),
            ],
          ),

          const SizedBox(height: 8),

          //====================================================================
          //! PRICE
          //====================================================================
          Text(
            '₱${data.price.toStringAsFixed(0)} / month',
            style: AppTextStyles.body.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  //============================================================================
  //! HERO IMAGE
  //============================================================================

  Widget _buildHeroImage({required String imageUrl, required double size}) {
    if (imageUrl.isEmpty) {
      return Container(
        width: size,
        height: size,

        decoration: BoxDecoration(
          color: AppColors.tertiary.withValues(alpha: .10),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),

        child: const Icon(
          Icons.image_outlined,
          size: 30,
          color: AppColors.tertiary,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.sm),

      child: Image.network(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,

        errorBuilder: (_, __, ___) {
          return Container(
            width: size,
            height: size,

            color: AppColors.tertiary.withValues(alpha: .10),

            child: const Icon(
              Icons.broken_image_outlined,
              size: 30,
              color: AppColors.tertiary,
            ),
          );
        },
      ),
    );
  }

  //============================================================================
  //! ROOM INFO
  //============================================================================

  Widget _buildRoomInfo({required IconData icon, required String text}) {
    return Row(
      mainAxisSize: MainAxisSize.min,

      children: [
        Icon(icon, size: 18, color: AppColors.secondary),

        const SizedBox(width: 6),

        Text(text, style: AppTextStyles.subtitle),
      ],
    );
  }

  //============================================================================
  //! FORMAT GENDER
  //============================================================================

  String _formatGender(GenderPreference gender) {
    switch (gender) {
      case GenderPreference.male:
        return 'Male Only';

      case GenderPreference.female:
        return 'Female Only';

      case GenderPreference.mixed:
        return 'Mixed';
    }
  }
}
