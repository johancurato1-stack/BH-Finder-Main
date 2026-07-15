import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/features/messages/widgets/chat/chat_tile.dart';
import 'package:bh_finder/features/messages/screens/notification_chat_screen.dart';
import 'package:bh_finder/features/messages/screens/chat_room_screen.dart';
import 'package:bh_finder/features/messages/screens/new_message_screen.dart';
import 'package:bh_finder/features/messages/repositories/chat_repository.dart';
import 'package:bh_finder/features/messages/models/chat_model.dart';
import 'package:bh_finder/features/messages/widgets/notification/notification_tile.dart';

class MessagesScreen extends StatefulWidget {
  final VoidCallback onBackPressed;

  const MessagesScreen({super.key, required this.onBackPressed});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final ChatRepository _repository = ChatRepository();
  late Future<List<ChatModel>> _conversationsFuture;

  @override
  void initState() {
    super.initState();
    _conversationsFuture = _repository.fetchConversations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  const Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewMessageScreen(),
                      ),
                    ),
                    icon: const Icon(
                      Icons.add_to_photos_outlined,
                      color: AppColors.primary,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.tertiary.withValues(alpha: 0.3),
                    width: 0.5,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            fontFamily: 'Roboto',
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
            Expanded(
              child: FutureBuilder<List<ChatModel>>(
                future: _conversationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error loading messages: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No conversations found."));
                  }

                  final conversations = snapshot.data!;

                  return ListView.separated(
                    itemCount: conversations.length + 1,
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => Divider(
                      color: AppColors.tertiary.withValues(alpha: 0.1),
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return NotificationTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const NotificationChatScreen(),
                              ),
                            );
                          },
                        );
                      }

                      final chatItem = conversations[index - 1];
                      return ChatTile(
                        chat: chatItem,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(chat: chatItem),
                          ),
                        ),
                      );
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
