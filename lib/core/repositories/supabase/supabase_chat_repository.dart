import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/models/chat_model.dart';
import 'package:bh_finder/core/models/message_model.dart';

import 'package:bh_finder/core/repositories/repositories/chat_repository.dart';
import 'package:bh_finder/core/repositories/repositories/storage_repository.dart';

//============================================================================
//! SUPABASE CHAT REPOSITORY
//============================================================================

class SupabaseChatRepository implements ChatRepository {
  //============================================================================
  //! FIELDS
  //============================================================================

  final SupabaseClient _supabase = Supabase.instance.client;

  final StorageRepository _storageRepository;

  RealtimeChannel? _messageChannel;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  SupabaseChatRepository({required StorageRepository storageRepository})
    : _storageRepository = storageRepository;

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
  //! GET PENDING USER ID
  //============================================================================

  @override
  Future<String?> getPendingUserId(String chatId) async {
    final response = await _supabase
        .from('chats')
        .select('pending_user_id')
        .eq('id', chatId)
        .single();

    return response['pending_user_id'] as String?;
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
          user_1_id,
          user_2_id,
          property_id,
          access_status,
          pending_user_id,
          pending_since,
          last_inquiry_at,
          last_inquiry_sender_id,
          updated_at,
          user_1_deleted_at,
          user_2_deleted_at
        ''')
        .or('user_1_id.eq.$userId,user_2_id.eq.$userId')
        .eq('status', 'active')
        .order('updated_at', ascending: false);

    final chats = <ChatModel>[];

    for (final row in response) {
      final chatId = row['id'] as String;

      final user1Id = row['user_1_id'] as String;

      final user2Id = row['user_2_id'] as String;

      //========================================================================
      //! HIDE DELETED CHAT FOR CURRENT USER
      //========================================================================

      final user1DeletedAt = row['user_1_deleted_at'];

      final user2DeletedAt = row['user_2_deleted_at'];

      if (userId == user1Id && user1DeletedAt != null) {
        continue;
      }

      if (userId == user2Id && user2DeletedAt != null) {
        continue;
      }

      //========================================================================
      //! OTHER PARTICIPANT
      //========================================================================

      final otherParticipantId = userId == user1Id ? user2Id : user1Id;

      //========================================================================
      //! OTHER PARTICIPANT PROFILE
      //========================================================================

      final profile = await _supabase
          .from('profiles')
          .select('first_name, last_name, avatar_path, last_seen_at')
          .eq('id', otherParticipantId)
          .maybeSingle();

      String participantName = '';

      String avatarUrl = '';

      bool isOnline = false;

      DateTime? lastSeenAt;

      if (profile != null) {
        participantName =
            '${profile['first_name'] ?? ''} ${profile['last_name'] ?? ''}'
                .trim();

        //======================================================================
        //! AVATAR URL
        //======================================================================

        final avatarPath = profile['avatar_path'] as String?;

        if (avatarPath != null && avatarPath.isNotEmpty) {
          avatarUrl = _storageRepository.getPublicUrl(
            'avatars',
            avatarPath.replaceFirst('avatars/', ''),
          );
        }

        //======================================================================
        //! LAST SEEN
        //======================================================================

        final lastSeenValue = profile['last_seen_at'];

        if (lastSeenValue != null) {
          lastSeenAt = DateTime.tryParse(lastSeenValue.toString());

          if (lastSeenAt != null) {
            final lastSeenUtc = lastSeenAt.toUtc();

            final now = DateTime.now().toUtc();

            isOnline = now.difference(lastSeenUtc).inMinutes <= 2;
          }
        }
      }

      //========================================================================
      //! LAST MESSAGE
      //========================================================================

      final lastMessage = await _supabase
          .from('messages')
          .select('content, message_type, created_at')
          .eq('chat_id', chatId)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();

      String lastMessageText = '';

      DateTime? lastMessageAt;

      if (lastMessage != null) {
        lastMessageText = lastMessage['content'] as String? ?? '';

        final createdAt = lastMessage['created_at'];

        if (createdAt != null) {
          lastMessageAt = DateTime.tryParse(createdAt.toString());
        }
      }

      //========================================================================
      //! UNREAD COUNT
      //========================================================================

      final unreadResponse = await _supabase
          .from('messages')
          .select('id')
          .eq('chat_id', chatId)
          .eq('is_read', false)
          .neq('sender_id', userId);

      final unreadCount = unreadResponse.length;

      //========================================================================
      //! ACCESS STATUS
      //========================================================================

      final databaseAccessStatus = row['access_status'] as String? ?? 'locked';

      final pendingUserId = row['pending_user_id'] as String?;

      String accessStatus = databaseAccessStatus;

      if (databaseAccessStatus == 'pending' && pendingUserId != null) {
        if (pendingUserId == userId) {
          accessStatus = 'pending_sender';
        } else {
          accessStatus = 'pending';
        }
      }

      //========================================================================
      //! ADD CHAT
      //========================================================================

      chats.add(
        ChatModel(
          id: chatId,
          landlordId: otherParticipantId,
          landlordName: participantName,
          avatarUrl: avatarUrl,
          isOnline: isOnline,
          lastSeenAt: lastSeenAt,
          lastMessage: lastMessageText,
          lastMessageAt: lastMessageAt,
          unreadCount: unreadCount,
          accessStatus: accessStatus,
          pendingUserId: pendingUserId,
          pendingSince: row['pending_since'] != null
              ? DateTime.tryParse(row['pending_since'].toString())
              : null,
        ),
      );
    }

    return chats;
  }

  //============================================================================
  //! GET CHAT ACCESS STATUS
  //============================================================================

  @override
  Future<String> getChatAccessStatus(String chatId) async {
    final userId = currentUserId;

    final response = await _supabase
        .from('chats')
        .select('access_status, pending_user_id, pending_since')
        .eq('id', chatId)
        .single();

    final accessStatus = response['access_status'] as String;

    final pendingUserId = response['pending_user_id'] as String?;

    final pendingSinceValue = response['pending_since'];

    //==========================================================================
    //! BLOCKED
    //==========================================================================

    if (accessStatus == 'blocked') {
      return 'blocked';
    }

    //==========================================================================
    //! PENDING
    //==========================================================================

    if (accessStatus == 'pending') {
      //========================================================================
      //! CURRENT USER SENT THE INQUIRY
      //========================================================================

      if (pendingUserId == userId) {
        return 'pending_sender';
      }

      //========================================================================
      //! CURRENT USER RECEIVED THE INQUIRY
      //========================================================================

      if (pendingUserId != null) {
        //======================================================================
        //! AUTO DECLINE AFTER 30 MINUTES
        //======================================================================

        if (pendingSinceValue != null) {
          final pendingSince = DateTime.tryParse(pendingSinceValue.toString());

          if (pendingSince != null) {
            final elapsed = DateTime.now().toUtc().difference(
              pendingSince.toUtc(),
            );

            if (elapsed.inMinutes >= 30) {
              await declineChat(chatId);

              return 'locked';
            }
          }
        }

        return 'pending';
      }
    }

    return accessStatus;
  }

  //============================================================================
  //! ACCEPT CHAT
  //============================================================================

  @override
  Future<void> acceptChat(String chatId) async {
    final userId = currentUserId;

    final response = await _supabase
        .from('chats')
        .select('user_1_id, user_2_id, pending_user_id, access_status')
        .eq('id', chatId)
        .single();

    final user1Id = response['user_1_id'] as String;

    final user2Id = response['user_2_id'] as String;

    final pendingUserId = response['pending_user_id'] as String?;

    final accessStatus = response['access_status'] as String;

    if (userId != user1Id && userId != user2Id) {
      throw Exception('You are not a participant in this chat.');
    }

    if (accessStatus != 'pending') {
      throw Exception('There is no pending chat request.');
    }

    if (pendingUserId == null) {
      throw Exception('There is no pending chat request.');
    }

    if (pendingUserId == userId) {
      throw Exception('You cannot accept your own chat request.');
    }

    await _supabase
        .from('chats')
        .update({
          'access_status': 'unlocked',
          'pending_user_id': null,
          'pending_since': null,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', chatId);
  }

  //============================================================================
  //! DECLINE CHAT
  //============================================================================

  @override
  Future<void> declineChat(String chatId) async {
    await _supabase
        .from('chats')
        .update({
          'access_status': 'locked',
          'pending_user_id': null,
          'pending_since': null,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', chatId);
  }

  //============================================================================
  //! BLOCK CHAT
  //============================================================================

  @override
  Future<void> blockChat(String chatId) async {
    await _supabase
        .from('chats')
        .update({
          'access_status': 'blocked',
          'pending_user_id': null,
          'pending_since': null,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', chatId);
  }

  //============================================================================
  //! UNBLOCK CHAT
  //============================================================================

  @override
  Future<void> unblockChat(String chatId) async {
    await _supabase
        .from('chats')
        .update({
          'access_status': 'locked',
          'pending_user_id': null,
          'pending_since': null,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', chatId);
  }

  //============================================================================
  //! DELETE CHAT FOR CURRENT USER
  //============================================================================

  @override
  Future<void> deleteChat(String chatId) async {
    final userId = currentUserId;

    final chat = await _supabase
        .from('chats')
        .select('user_1_id, user_2_id')
        .eq('id', chatId)
        .single();

    final user1Id = chat['user_1_id'] as String;

    final user2Id = chat['user_2_id'] as String;

    //==========================================================================
    //! VERIFY PARTICIPANT
    //==========================================================================

    if (userId != user1Id && userId != user2Id) {
      throw Exception('You are not a participant in this chat.');
    }

    final deletedAt = DateTime.now().toUtc().toIso8601String();

    //==========================================================================
    //! USER 1 DELETE
    //==========================================================================

    if (userId == user1Id) {
      await _supabase
          .from('chats')
          .update({'user_1_deleted_at': deletedAt})
          .eq('id', chatId);

      return;
    }

    //==========================================================================
    //! USER 2 DELETE
    //==========================================================================

    await _supabase
        .from('chats')
        .update({'user_2_deleted_at': deletedAt})
        .eq('id', chatId);
  }

  //============================================================================
  //! GET OR CREATE CHAT
  //============================================================================

  @override
  Future<String> getOrCreateChat({
    required String user2Id,
    required String propertyId,
  }) async {
    final user1Id = currentUserId;

    final users = [user1Id, user2Id]..sort();

    final user1 = users[0];

    final user2 = users[1];

    //==========================================================================
    //! FIND EXISTING CHAT
    //==========================================================================

    final existingChat = await _supabase
        .from('chats')
        .select('id, user_1_deleted_at, user_2_deleted_at')
        .eq('user_1_id', user1)
        .eq('user_2_id', user2)
        .maybeSingle();

    if (existingChat != null) {
      final chatId = existingChat['id'] as String;

      //======================================================================
      //! RESTORE CURRENT USER VISIBILITY
      //======================================================================

      if (user1Id == user1) {
        await _supabase
            .from('chats')
            .update({'user_1_deleted_at': null})
            .eq('id', chatId);
      } else {
        await _supabase
            .from('chats')
            .update({'user_2_deleted_at': null})
            .eq('id', chatId);
      }

      return chatId;
    }

    //==========================================================================
    //! CREATE NEW CHAT
    //==========================================================================

    try {
      final response = await _supabase
          .from('chats')
          .insert({
            'user_1_id': user1,
            'user_2_id': user2,
            'property_id': propertyId,
            'status': 'active',
            'access_status': 'locked',
            'pending_user_id': null,
            'pending_since': null,
            'last_inquiry_at': null,
            'last_inquiry_sender_id': null,
            'user_1_deleted_at': null,
            'user_2_deleted_at': null,
          })
          .select('id')
          .single();

      return response['id'] as String;
    } catch (_) {
      //========================================================================
      //! HANDLE RACE CONDITION
      //========================================================================

      final existingChat = await _supabase
          .from('chats')
          .select('id')
          .eq('user_1_id', user1)
          .eq('user_2_id', user2)
          .maybeSingle();

      if (existingChat != null) {
        final chatId = existingChat['id'] as String;

        if (user1Id == user1) {
          await _supabase
              .from('chats')
              .update({'user_1_deleted_at': null})
              .eq('id', chatId);
        } else {
          await _supabase
              .from('chats')
              .update({'user_2_deleted_at': null})
              .eq('id', chatId);
        }

        return chatId;
      }

      rethrow;
    }
  }

  //============================================================================
  //! FETCH MESSAGES
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
  //! MARK MESSAGES AS READ
  //============================================================================

  @override
  Future<void> markMessagesAsRead(String chatId) async {
    final userId = currentUserId;

    await _supabase
        .from('messages')
        .update({'is_read': true})
        .eq('chat_id', chatId)
        .eq('is_read', false)
        .neq('sender_id', userId);
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

    //==========================================================================
    //! VERIFY CHAT ACCESS
    //==========================================================================

    final accessStatus = await getChatAccessStatus(chatId);

    if (accessStatus == 'blocked') {
      throw Exception('This chat is blocked.');
    }

    if (accessStatus != 'unlocked') {
      throw Exception(
        'This chat is locked. Send an inquiry to request access.',
      );
    }

    //==========================================================================
    //! SEND TEXT MESSAGE
    //==========================================================================

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

    //==========================================================================
    //! UPDATE CHAT TIMESTAMP
    //==========================================================================

    await _supabase
        .from('chats')
        .update({'updated_at': DateTime.now().toUtc().toIso8601String()})
        .eq('id', chatId);

    return _mapMessage(response, currentUserId: userId);
  }

  //============================================================================
  //! SEND INQUIRY MESSAGE
  //============================================================================

  @override
  Future<MessageModel> sendInquiryMessage({
    required String chatId,
    required String inquiryId,
    required String text,
  }) async {
    final userId = currentUserId;

    final trimmedText = text.trim();

    //==========================================================================
    //! GET CHAT STATE
    //==========================================================================

    final chat = await _supabase
        .from('chats')
        .select('''
          user_1_id,
          user_2_id,
          access_status,
          pending_user_id,
          pending_since,
          last_inquiry_at,
          last_inquiry_sender_id
        ''')
        .eq('id', chatId)
        .single();

    final user1Id = chat['user_1_id'] as String;

    final user2Id = chat['user_2_id'] as String;

    final accessStatus = chat['access_status'] as String;

    final pendingUserId = chat['pending_user_id'] as String?;

    final pendingSinceValue = chat['pending_since'];

    final lastInquiryValue = chat['last_inquiry_at'];

    final lastInquirySenderId = chat['last_inquiry_sender_id'] as String?;

    //==========================================================================
    //! VERIFY PARTICIPANT
    //==========================================================================

    if (userId != user1Id && userId != user2Id) {
      throw Exception('You are not a participant in this chat.');
    }

    //==========================================================================
    //! BLOCKED
    //==========================================================================

    if (accessStatus == 'blocked') {
      throw Exception('This chat is blocked.');
    }

    //==========================================================================
    //! AUTO EXPIRE PENDING REQUEST
    //==========================================================================

    var currentAccessStatus = accessStatus;

    var currentPendingUserId = pendingUserId;

    var currentPendingSinceValue = pendingSinceValue;

    if (currentAccessStatus == 'pending' &&
        currentPendingUserId != null &&
        currentPendingSinceValue != null) {
      final pendingSince = DateTime.tryParse(
        currentPendingSinceValue.toString(),
      );

      if (pendingSince != null) {
        final elapsed = DateTime.now().toUtc().difference(pendingSince.toUtc());

        if (elapsed.inMinutes >= 30) {
          currentAccessStatus = 'locked';

          currentPendingUserId = null;

          currentPendingSinceValue = null;

          await _supabase
              .from('chats')
              .update({
                'access_status': 'locked',
                'pending_user_id': null,
                'pending_since': null,
                'updated_at': DateTime.now().toUtc().toIso8601String(),
              })
              .eq('id', chatId);
        }
      }
    }

    //==========================================================================
    //! SENDER-SPECIFIC 30-MINUTE COOLDOWN
    //==========================================================================

    if (lastInquiryValue != null &&
        lastInquirySenderId != null &&
        lastInquirySenderId == userId) {
      final lastInquiryAt = DateTime.tryParse(lastInquiryValue.toString());

      if (lastInquiryAt != null) {
        final elapsed = DateTime.now().toUtc().difference(
          lastInquiryAt.toUtc(),
        );

        if (elapsed.inMinutes < 30) {
          final remainingMinutes = 30 - elapsed.inMinutes;

          throw Exception(
            'You can send another inquiry in '
            '$remainingMinutes minute'
            '${remainingMinutes == 1 ? '' : 's'}.',
          );
        }
      }
    }

    //==========================================================================
    //! CREATE INQUIRY MESSAGE
    //==========================================================================

    final response = await _supabase
        .from('messages')
        .insert({
          'chat_id': chatId,
          'sender_id': userId,
          'message_type': 'inquiry',
          'content': trimmedText,
          'inquiry_id': inquiryId,
        })
        .select()
        .single();

    final now = DateTime.now().toUtc();

    //==========================================================================
    //! DETERMINE NEW CHAT STATE
    //==========================================================================

    String newAccessStatus = currentAccessStatus;

    String? newPendingUserId = currentPendingUserId;

    String? newPendingSince = currentPendingSinceValue?.toString();

    if (currentAccessStatus == 'unlocked') {
      //========================================================================
      //! ALREADY UNLOCKED
      //========================================================================

      newAccessStatus = 'unlocked';

      newPendingUserId = null;

      newPendingSince = null;
    } else if (currentAccessStatus == 'locked') {
      //========================================================================
      //! FIRST INQUIRY
      //========================================================================

      newAccessStatus = 'pending';

      newPendingUserId = userId;

      newPendingSince = now.toIso8601String();
    } else if (currentAccessStatus == 'pending') {
      //========================================================================
      //! RECIPROCAL INQUIRY
      //========================================================================

      if (currentPendingUserId != null && currentPendingUserId != userId) {
        newAccessStatus = 'unlocked';

        newPendingUserId = null;

        newPendingSince = null;
      } else {
        //======================================================================
        //! SAME USER SENT ANOTHER CARD
        //======================================================================

        newAccessStatus = 'pending';

        newPendingUserId = userId;

        newPendingSince = currentPendingSinceValue?.toString();
      }
    }

    //==========================================================================
    //! UPDATE CHAT
    //==========================================================================

    await _supabase
        .from('chats')
        .update({
          'last_inquiry_at': now.toIso8601String(),
          'last_inquiry_sender_id': userId,
          'updated_at': now.toIso8601String(),
          'access_status': newAccessStatus,
          'pending_user_id': newPendingUserId,
          'pending_since': newPendingSince,
        })
        .eq('id', chatId);

    //==========================================================================
    //! RETURN MESSAGE
    //==========================================================================

    return _mapMessage(response, currentUserId: userId);
  }

  //============================================================================
  //! REALTIME MESSAGES
  //============================================================================

  @override
  Stream<MessageModel> subscribeToMessages(String chatId) {
    final userId = currentUserId;

    _messageChannel?.unsubscribe();

    final controller = StreamController<MessageModel>();

    _messageChannel = _supabase
        .channel('chat_messages_$chatId')
        //========================================================================
        //! NEW MESSAGE
        //========================================================================
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'chat_id',
            value: chatId,
          ),
          callback: (payload) {
            final row = payload.newRecord;

            if (row.isEmpty) {
              return;
            }

            final message = _mapMessage(row, currentUserId: userId);

            controller.add(message);
          },
        )
        //========================================================================
        //! MESSAGE READ STATUS CHANGED
        //========================================================================
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'messages',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'chat_id',
            value: chatId,
          ),
          callback: (payload) {
            final row = payload.newRecord;

            if (row.isEmpty) {
              return;
            }

            final message = _mapMessage(row, currentUserId: userId);

            controller.add(message);
          },
        )
        .subscribe();

    controller.onCancel = () async {
      await unsubscribeFromMessages();
    };

    return controller.stream;
  }

  //============================================================================
  //! CLOSE REALTIME
  //============================================================================

  @override
  Future<void> unsubscribeFromMessages() async {
    if (_messageChannel == null) {
      return;
    }

    await _messageChannel!.unsubscribe();

    _messageChannel = null;
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
      orElse: () => MessageType.text,
    );

    final isMe = row['sender_id'] == currentUserId;

    final isRead = row['is_read'] as bool? ?? false;

    return MessageModel(
      id: row['id'] as String,
      chatId: row['chat_id'] as String,
      senderId: row['sender_id'] as String,
      text: row['content'] as String? ?? '',
      isMe: isMe,
      type: messageType,
      status: isMe && isRead ? MessageStatus.seen : MessageStatus.sent,
      sentAt: DateTime.parse(row['created_at'] as String),
      inquiryId: row['inquiry_id'] as String?,
    );
  }
}
