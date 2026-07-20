import 'dart:async';

import 'package:bh_finder/shared/widgets/messages/data/mock_chat.dart';
import 'package:bh_finder/shared/widgets/messages/data/mock_messages.dart';
import 'package:bh_finder/shared/widgets/messages/models/chat_model.dart';
import 'package:bh_finder/shared/widgets/messages/models/message_model.dart';

class ChatRepository {
  //============================================================================
  //! CONVERSATIONS
  //============================================================================

  Future<List<ChatModel>> fetchConversations() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return MockChat.conversations;
  }

  //============================================================================
  //! MESSAGES
  //============================================================================

  Future<List<MessageModel>> fetchMessages(String chatId) async {
    await Future.delayed(const Duration(milliseconds: 250));

    return List.from(MockMessages.messages[chatId] ?? []);
  }

  //============================================================================
  //! SEND MESSAGE
  //============================================================================

  Future<MessageModel> sendMessage({
    required String chatId,
    required String text,
  }) async {
    await Future.delayed(const Duration(milliseconds: 150));

    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: chatId,
      senderId: "tenant",
      text: text,
      isMe: true,
      type: MessageType.text,
      status: MessageStatus.sent,
      sentAt: DateTime.now(),
    );

    MockMessages.messages.putIfAbsent(chatId, () => []);

    MockMessages.messages[chatId]!.insert(0, message);

    return message;
  }
}
