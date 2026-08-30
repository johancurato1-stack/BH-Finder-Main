import 'package:bh_finder/core/models/chat_model.dart';
import 'package:bh_finder/core/models/message_model.dart';

//============================================================================
//! CHAT REPOSITORY
//============================================================================

abstract class ChatRepository {
  //============================================================================
  //! CURRENT USER
  //============================================================================

  String get currentUserId;

  //============================================================================
  //! CONVERSATIONS
  //============================================================================

  Future<List<ChatModel>> fetchConversations();

  //============================================================================
  //! CHAT ACCESS
  //============================================================================

  Future<String> getChatAccessStatus(String chatId);

  Future<String?> getPendingUserId(String chatId);

  Future<void> acceptChat(String chatId);

  Future<void> declineChat(String chatId);

  Future<void> blockChat(String chatId);

  Future<void> unblockChat(String chatId);

  //============================================================================
  //! DELETE CHAT FOR CURRENT USER
  //============================================================================

  Future<void> deleteChat(String chatId);

  //============================================================================
  //! MESSAGES
  //============================================================================

  Future<List<MessageModel>> fetchMessages(String chatId);

  //============================================================================
  //! MARK MESSAGES AS READ
  //============================================================================

  Future<void> markMessagesAsRead(String chatId);

  //============================================================================
  //! SEND MESSAGE
  //============================================================================

  Future<MessageModel> sendMessage({
    required String chatId,
    required String text,
  });

  //============================================================================
  //! SEND INQUIRY MESSAGE
  //============================================================================

  Future<MessageModel> sendInquiryMessage({
    required String chatId,
    required String inquiryId,
    required String text,
  });

  //============================================================================
  //! GET OR CREATE CHAT
  //============================================================================

  Future<String> getOrCreateChat({
    required String user2Id,
    required String propertyId,
  });

  //============================================================================
  //! REALTIME MESSAGES
  //============================================================================

  Stream<MessageModel> subscribeToMessages(String chatId);

  //============================================================================
  //! CLOSE REALTIME
  //============================================================================

  Future<void> unsubscribeFromMessages();
}
