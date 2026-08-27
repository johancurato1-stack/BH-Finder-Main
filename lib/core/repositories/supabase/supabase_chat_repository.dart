import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/models/chat_model.dart';
import 'package:bh_finder/core/models/inquiry_model.dart';
import 'package:bh_finder/core/models/message_model.dart';

import 'package:bh_finder/core/repositories/repositories/chat_repository.dart';

//============================================================================
//! SUPABASE CHAT REPOSITORY
//============================================================================

class SupabaseChatRepository implements ChatRepository {
  //============================================================================
  //! FIELDS
  //============================================================================

  final SupabaseClient _supabase = Supabase.instance.client;

  //============================================================================
  //! CURRENT USER
  //============================================================================

  @override
  String get currentUserId {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      throw Exception('User is not authenticated.');
    }

    return userId;
  }

  //============================================================================
  //! CONVERSATIONS
  //============================================================================

  @override
  Future<List<ChatModel>> fetchConversations() async {
    final userId = currentUserId;

    final response = await _supabase
        .from('chats')
        .select('''
          id,
          tenant_id,
          landlord_id,
          status,
          created_at,
          updated_at
        ''')
        .or('tenant_id.eq.$userId,landlord_id.eq.$userId')
        .order('updated_at', ascending: false);

    final chats = <ChatModel>[];

    for (final row in response) {
      final chatId = row['id'] as String;
      final tenantId = row['tenant_id'] as String;
      final landlordId = row['landlord_id'] as String;

      final otherParticipantId = userId == tenantId ? landlordId : tenantId;

      final profile = await _supabase
          .from('profiles')
          .select('first_name, last_name, avatar_path')
          .eq('id', otherParticipantId)
          .maybeSingle();

      String participantName = '';
      String avatarUrl = '';

      if (profile != null) {
        participantName =
            '${profile['first_name'] ?? ''} ${profile['last_name'] ?? ''}'
                .trim();

        avatarUrl = profile['avatar_path'] as String? ?? '';
      }

      final lastMessage = await _supabase
          .from('messages')
          .select('content, message_type')
          .eq('chat_id', chatId)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();

      String lastMessageText = '';

      if (lastMessage != null) {
        if (lastMessage['message_type'] == 'inquiry') {
          lastMessageText = 'Inquiry';
        } else {
          lastMessageText = lastMessage['content'] as String? ?? '';
        }
      }

      final unread = await _supabase
          .from('messages')
          .select('id')
          .eq('chat_id', chatId)
          .eq('is_read', false)
          .neq('sender_id', userId);

      chats.add(
        ChatModel(
          id: chatId,
          landlordId: landlordId,
          landlordName: participantName,
          avatarUrl: avatarUrl,
          lastMessage: lastMessageText,
          isUnread: unread.isNotEmpty,
        ),
      );
    }

    return chats;
  }

  //============================================================================
  //! GET OR CREATE CHAT
  //============================================================================

  @override
  Future<String> getOrCreateChat({required String landlordId}) async {
    final tenantId = currentUserId;

    final existingChat = await _supabase
        .from('chats')
        .select('id')
        .eq('tenant_id', tenantId)
        .eq('landlord_id', landlordId)
        .maybeSingle();

    if (existingChat != null) {
      return existingChat['id'] as String;
    }

    try {
      final response = await _supabase
          .from('chats')
          .insert({
            'tenant_id': tenantId,
            'landlord_id': landlordId,
            'status': 'pending',
          })
          .select('id')
          .single();

      return response['id'] as String;
    } catch (e) {
      final existingChat = await _supabase
          .from('chats')
          .select('id')
          .eq('tenant_id', tenantId)
          .eq('landlord_id', landlordId)
          .maybeSingle();

      if (existingChat != null) {
        return existingChat['id'] as String;
      }

      rethrow;
    }
  }

  //============================================================================
  //! MESSAGES
  //============================================================================

  @override
  Future<List<MessageModel>> fetchMessages(String chatId) async {
    final userId = currentUserId;

    final response = await _supabase
        .from('messages')
        .select()
        .eq('chat_id', chatId)
        .order('created_at', ascending: false);

    return response.map<MessageModel>((row) {
      return _mapMessage(row, currentUserId: userId);
    }).toList();
  }

  //============================================================================
  //! SEND MESSAGE
  //============================================================================

  @override
  Future<MessageModel> sendMessage({
    required String chatId,
    required String text,
  }) async {
    final userId = currentUserId;

    final trimmedText = text.trim();

    if (trimmedText.isEmpty) {
      throw Exception('Message cannot be empty.');
    }

    final response = await _supabase
        .from('messages')
        .insert({
          'chat_id': chatId,
          'sender_id': userId,
          'message_type': 'text',
          'content': trimmedText,
        })
        .select()
        .single();

    await _supabase
        .from('chats')
        .update({'updated_at': DateTime.now().toUtc().toIso8601String()})
        .eq('id', chatId);

    return _mapMessage(response, currentUserId: userId);
  }

  //============================================================================
  //! SEND INQUIRY
  //============================================================================

  @override
  Future<MessageModel> sendInquiry({required InquiryModel inquiry}) async {
    final userId = currentUserId;

    if (inquiry.tenantId != userId) {
      throw Exception('Inquiry does not belong to the current user.');
    }

    final inquiryResponse = await _supabase
        .from('inquiries')
        .insert({
          'chat_id': inquiry.chatId,
          'tenant_id': inquiry.tenantId,
          'landlord_id': inquiry.landlordId,
          'room_id': inquiry.roomId,
          'room_title': inquiry.roomTitle,
          'room_price': inquiry.roomPrice,
          'room_capacity': inquiry.roomCapacity,
          'gender_preference': inquiry.genderPreference.name,
          'message': inquiry.message,
          'status': inquiry.status.name,
        })
        .select()
        .single();

    final inquiryId = inquiryResponse['id'] as String;

    final messageResponse = await _supabase
        .from('messages')
        .insert({
          'chat_id': inquiry.chatId,
          'sender_id': userId,
          'message_type': 'inquiry',
          'content': inquiry.message,
          'inquiry_id': inquiryId,
        })
        .select()
        .single();

    await _supabase
        .from('chats')
        .update({
          'status': 'active',
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', inquiry.chatId);

    return _mapMessage(messageResponse, currentUserId: userId);
  }

  //============================================================================
  //! MAP MESSAGE
  //============================================================================

  MessageModel _mapMessage(
    Map<String, dynamic> row, {
    required String currentUserId,
  }) {
    final messageType = MessageType.values.firstWhere(
      (e) => e.name == row['message_type'],
    );

    return MessageModel(
      id: row['id'] as String,
      chatId: row['chat_id'] as String,
      senderId: row['sender_id'] as String,
      text: row['content'] as String? ?? '',
      isMe: row['sender_id'] == currentUserId,
      type: messageType,
      status: MessageStatus.sent,
      sentAt: DateTime.parse(row['created_at'] as String),
      inquiryId: row['inquiry_id'] as String?,
    );
  }
}
