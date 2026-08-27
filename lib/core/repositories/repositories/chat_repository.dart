import 'package:bh_finder/core/models/chat_model.dart';
import 'package:bh_finder/core/models/inquiry_model.dart';
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
  //! MESSAGES
  //============================================================================

  Future<List<MessageModel>> fetchMessages(String chatId);

  //============================================================================
  //! SEND MESSAGE
  //============================================================================

  Future<MessageModel> sendMessage({
    required String chatId,
    required String text,
  });

  //============================================================================
  //! SEND INQUIRY
  //============================================================================

  Future<MessageModel> sendInquiry({required InquiryModel inquiry});

  //============================================================================
  //! GET OR CREATE CHAT
  //============================================================================

  Future<String> getOrCreateChat({required String landlordId});
}
