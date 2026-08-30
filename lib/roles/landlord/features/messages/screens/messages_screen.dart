import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

import 'package:bh_finder/core/models/chat_model.dart';

import 'package:bh_finder/core/repositories/repositories/repositories.dart';
import 'package:bh_finder/core/view_models/chat_view_model.dart';

import 'package:bh_finder/roles/landlord/features/messages/screens/chat_room_screen.dart';
import 'package:bh_finder/roles/landlord/features/messages/screens/new_message_screen.dart';
import 'package:bh_finder/roles/landlord/features/messages/screens/notification_chat_screen.dart';

import 'package:bh_finder/shared/widgets/messages/chat/chat_tile.dart';
import 'package:bh_finder/shared/widgets/messages/notification/notification_tile.dart';

//============================================================================
//! MESSAGES SCREEN
//============================================================================

class MessagesScreen extends StatefulWidget {
  //============================================================================
  //! VARIABLES
  //============================================================================

  final VoidCallback onBackPressed;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const MessagesScreen({super.key, required this.onBackPressed});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _MessagesScreenState extends State<MessagesScreen> {
  //============================================================================
  //! VIEW MODEL
  //============================================================================

  late final ChatViewModel _viewModel;

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    final repositories = Repositories.instance;

    _viewModel = ChatViewModel(
      repository: repositories.chatRepository,
      inquiryRepository: repositories.inquiryRepository,
    );

    _viewModel.fetchConversations();
  }

  @override
  void dispose() {
    _viewModel.dispose();

    super.dispose();
  }

  //============================================================================
  //! METHODS
  //============================================================================

  Future<void> _refreshConversations() async {
    await _viewModel.fetchConversations();
  }

  void _openNewMessage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NewMessageScreen()),
    ).then((_) {
      _refreshConversations();
    });
  }

  void _openNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NotificationChatScreen()),
    ).then((_) {
      _refreshConversations();
    });
  }

  void _openChat(ChatModel chat) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChatRoomScreen(chat: chat)),
    ).then((_) {
      _refreshConversations();
    });
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
            //====================================================================
            //! HEADER
            //====================================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  IconButton(
                    onPressed: widget.onBackPressed,

                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.secondary,
                      size: 24,
                    ),
                  ),

                  Text(
                    'Messages',
                    style: AppTextStyles.heading2.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  IconButton(
                    onPressed: _openNewMessage,

                    icon: const Icon(
                      Icons.add_to_photos_outlined,
                      color: AppColors.primary,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),

            //====================================================================
            //! SEARCH BAR
            //====================================================================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
                vertical: AppSpacing.sm,
              ),

              child: Container(
                height: 48,

                padding: const EdgeInsets.symmetric(horizontal: 16),

                decoration: BoxDecoration(
                  color: AppColors.white,

                  borderRadius: BorderRadius.circular(24),

                  border: Border.all(
                    color: AppColors.tertiary.withValues(alpha: .30),
                    width: .5,
                  ),
                ),

                child: const Row(
                  children: [
                    Icon(Icons.search, color: AppColors.tertiary, size: 20),

                    SizedBox(width: 10),

                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search messages',

                          hintStyle: TextStyle(
                            color: AppColors.tertiary,
                            fontSize: 14,
                          ),

                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 1),

            //====================================================================
            //! CONVERSATIONS
            //====================================================================
            Expanded(
              child: AnimatedBuilder(
                animation: _viewModel,

                builder: (context, _) {
                  if (_viewModel.isLoadingConversations) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (_viewModel.error != null) {
                    return Center(
                      child: Text(
                        'Error loading messages:\n${_viewModel.error}',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  final conversations = _viewModel.conversations;

                  if (conversations.isEmpty) {
                    return const Center(child: Text('No conversations found.'));
                  }

                  return ListView.separated(
                    itemCount: conversations.length + 1,

                    padding: const EdgeInsets.symmetric(vertical: 2),

                    physics: const BouncingScrollPhysics(),

                    separatorBuilder: (_, __) => Divider(
                      color: AppColors.tertiary.withValues(alpha: .10),
                      height: 1,
                    ),

                    itemBuilder: (context, index) {
                      //==========================================================
                      //! NOTIFICATION CHANNEL
                      //==========================================================

                      if (index == 0) {
                        return NotificationTile(onTap: _openNotifications);
                      }

                      //==========================================================
                      //! CHAT TILE
                      //==========================================================

                      final chat = conversations[index - 1];

                      return ChatTile(chat: chat, onTap: () => _openChat(chat));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
