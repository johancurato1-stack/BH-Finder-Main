import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

import 'package:bh_finder/core/data/mock/contacts/mock_contacts.dart';
import 'package:bh_finder/core/models/contact_model.dart';

class NewMessageScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const NewMessageScreen({super.key});

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  //============================================================================
  //! CONTROLLER
  //============================================================================

  final TextEditingController _searchController = TextEditingController();

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            //==========================================================================
            //! HEADER
            //==========================================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),

                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.secondary,
                      size: 24,
                    ),
                  ),

                  Text(
                    'New Message',
                    style: AppTextStyles.heading2.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(width: 48),
                ],
              ),
            ),

            //==========================================================================
            //! RECIPIENT SEARCH
            //==========================================================================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
                vertical: AppSpacing.md,
              ),

              child: Row(
                children: [
                  const Text('To:', style: AppTextStyles.bodyMedium),

                  const SizedBox(width: 16),

                  Expanded(
                    child: TextField(
                      controller: _searchController,

                      decoration: const InputDecoration(
                        hintText: 'Type a name or a group',
                        hintStyle: AppTextStyles.subtitle,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //==========================================================================
            //! CONTACT LIST
            //==========================================================================
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 2),

                children: [
                  //==============================================================
                  //! GROUP CHAT
                  //==============================================================
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 17,
                      backgroundColor: Color(0xFF2C2C2C),

                      child: Icon(Icons.group, color: Colors.white, size: 17),
                    ),

                    title: Text('Group Chat', style: AppTextStyles.bodyMedium),

                    onTap: () {},
                  ),

                  //==============================================================
                  //! SUGGESTED CONTACTS
                  //==============================================================
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),

                    child: Text('Suggested', style: AppTextStyles.bodyMedium),
                  ),

                  ...mockContacts.map((ContactModel contact) {
                    return ListTile(
                      leading: const CircleAvatar(
                        radius: 17,
                        backgroundColor: Color(0xFF2C2C2C),

                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),

                      title: Text(
                        contact.name,
                        style: AppTextStyles.bodyMedium,
                      ),

                      onTap: () {},
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
