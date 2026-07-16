import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

import 'package:bh_finder/roles/tenant/features/messages/models/chat_model.dart';
import 'package:bh_finder/roles/tenant/features/messages/repositories/chat_repository.dart';

import 'package:bh_finder/roles/tenant/features/messages/screens/chat_room_screen.dart';
import 'package:bh_finder/roles/tenant/features/messages/screens/new_message_screen.dart';
import 'package:bh_finder/roles/tenant/features/messages/screens/notification_chat_screen.dart';

import 'package:bh_finder/roles/tenant/features/messages/widgets/chat/chat_tile.dart';
import 'package:bh_finder/roles/tenant/features/messages/widgets/notification/notification_tile.dart';

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

class _MessagesScreenState extends State<MessagesScreen> {
  //============================================================================
  //! REPOSITORY
  //============================================================================

  final ChatRepository _repository = ChatRepository();

  //============================================================================
  //! STATE
  //============================================================================

  late Future<List<ChatModel>> _conversationsFuture;

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _conversationsFuture = _repository.fetchConversations();
  }

  //============================================================================
  //! METHODS
  //============================================================================

  void _openNewMessage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NewMessageScreen()),
    );
  }

  void _openNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NotificationChatScreen()),
    );
  }

  void _openChat(ChatModel chat) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChatScreen(chat: chat)),
    );
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

            //==========================================================================
            //! SEARCH BAR
            //==========================================================================
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

            //==========================================================================
            //! CONVERSATIONS
            //==========================================================================
            Expanded(
              child: FutureBuilder<List<ChatModel>>(
                future: _conversationsFuture,

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error loading messages:\n${snapshot.error}'),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No conversations found.'));
                  }

                  final conversations = snapshot.data!;

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
