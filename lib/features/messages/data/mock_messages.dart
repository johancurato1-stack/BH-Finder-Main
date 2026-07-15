import 'package:bh_finder/features/messages/models/message_model.dart';

class MockMessages {
  MockMessages._();

  //============================================================================
  //! CONVERSATION MESSAGES
  //============================================================================

  static final Map<String, List<MessageModel>> messages = {
    "chat_1": [
      MessageModel(
        id: "msg_1",
        chatId: "chat_1",
        senderId: "tenant",
        text: "",
        isMe: true,
        type: MessageType.inquiry,
        inquiryId: "inq_1",
        status: MessageStatus.seen,
        sentAt: DateTime(2026, 7, 15, 20, 10),
      ),

      MessageModel(
        id: "msg_2",
        chatId: "chat_1",
        senderId: "tenant",
        text: "Is this room available?",
        isMe: true,
        type: MessageType.text,
        status: MessageStatus.seen,
        sentAt: DateTime(2026, 7, 15, 20, 12),
      ),
    ],

    "chat_2": [
      MessageModel(
        id: "msg_3",
        chatId: "chat_2",
        senderId: "tenant",
        text: "Good afternoon! I'm interested in your boarding house.",
        isMe: true,
        type: MessageType.text,
        status: MessageStatus.delivered,
        sentAt: DateTime(2026, 7, 14, 14, 30),
      ),

      MessageModel(
        id: "msg_4",
        chatId: "chat_2",
        senderId: "landlord",
        text: "Sure! Feel free to ask anything.",
        isMe: false,
        type: MessageType.text,
        status: MessageStatus.seen,
        sentAt: DateTime(2026, 7, 14, 14, 32),
      ),
    ],

    "chat_3": [
      MessageModel(
        id: "msg_5",
        chatId: "chat_3",
        senderId: "tenant",
        text: "Can I reserve a room next week?",
        isMe: true,
        type: MessageType.text,
        status: MessageStatus.sent,
        sentAt: DateTime(2026, 7, 13, 10, 15),
      ),
    ],
  };
}
