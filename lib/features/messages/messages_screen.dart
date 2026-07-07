import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/features/messages/models/chat_model.dart';
import 'package:bh_finder/features/messages/widgets/chat_tile.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //!//!-----------------------------------------------------------------------------------------------------------------

    //* List View Data
    final List<ChatModel> activeConversations = [
      const ChatModel(
        id: '1',
        landlordName: 'Maria Santos',
        propertyTitle: 'Green Haven Boarding House',
        lastMessage:
            'Hello! Yes, the female slot is still available for viewing tomorrow.',
        timeStamp: '9:41 AM',
        avatarUrl:
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=150&auto=format&fit=crop',
        isUnread: true,
      ),
      const ChatModel(
        id: '2',
        landlordName: 'Juan Dela Cruz',
        propertyTitle: 'Blessed Home Boarding House',
        lastMessage:
            'The reservation fee is non-refundable, but it deducts from your first month.',
        timeStamp: 'Yesterday',
        avatarUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=150&auto=format&fit=crop',
      ),
    ];

    //!-----------------------------------------------------------------------------------------------------------------

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Back Icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.secondary,
                      size: 24,
                    ),
                  ),

                  //* Page Header
                  const Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary,
                      fontFamily: 'Roboto',
                    ),
                  ),

                  //* Write a Message Icon
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_to_photos_outlined,
                      color: AppColors.primary,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),

            //!-----------------------------------------------------------------------------------------------------------------

            //* Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.tertiary.withOpacity(0.3),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
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

            //!-----------------------------------------------------------------------------------------------------------------

            //* List View
            Expanded(
              child: activeConversations.isEmpty
                  ? Center(
                      child: Text(
                        'No conversations yet.',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.tertiary.withOpacity(0.8),
                          fontFamily: 'Roboto',
                        ),
                      ),
                    )
                  //* Divider
                  : ListView.separated(
                      itemCount: activeConversations.length,
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => Divider(
                        color: AppColors.tertiary.withOpacity(0.1),
                        height: 1,
                        indent: 0,
                      ),

                      itemBuilder: (context, index) {
                        return ChatTile(
                          chat: activeConversations[index],
                          onTap: () {
                            print(
                              "Opened centralized chat ID: ${activeConversations[index].id}",
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
