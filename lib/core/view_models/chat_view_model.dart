import 'package:flutter/foundation.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/models/chat_model.dart';
import 'package:bh_finder/core/models/inquiry_model.dart';
import 'package:bh_finder/core/models/message_model.dart';

import 'package:bh_finder/core/repositories/repositories/inquiry_repository.dart';
import 'package:bh_finder/core/repositories/repositories/chat_repository.dart';

//============================================================================
//! CHAT VIEW MODEL
//============================================================================

class ChatViewModel extends ChangeNotifier {
  //============================================================================
  //! REPOSITORIES
  //============================================================================

  final ChatRepository repository;

  final InquiryRepository inquiryRepository;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  ChatViewModel({required this.repository, required this.inquiryRepository});

  //============================================================================
  //! STATE
  //============================================================================

  List<ChatModel> _conversations = [];

  List<MessageModel> _messages = [];

  final Map<String, InquiryModel> _inquiries = {};

  bool _isLoadingConversations = false;

  bool _isLoadingMessages = false;

  bool _isSending = false;

  String? _error;

  String? _accessStatus;

  String? _pendingUserId;

  //============================================================================
  //! GETTERS
  //============================================================================

  List<ChatModel> get conversations => _conversations;

  List<MessageModel> get messages => _messages;

  bool get isLoadingConversations => _isLoadingConversations;

  bool get isLoadingMessages => _isLoadingMessages;

  bool get isSending => _isSending;

  String? get error => _error;

  String? get accessStatus => _accessStatus;

  String? get pendingUserId => _pendingUserId;

  //============================================================================
  //! ACCESS STATUS
  //============================================================================

  bool get isLocked => _accessStatus == 'locked';

  bool get isPending =>
      _accessStatus == 'pending' || _accessStatus == 'pending_sender';

  bool get isUnlocked => _accessStatus == 'unlocked';

  bool get isBlocked => _accessStatus == 'blocked';

  //============================================================================
  //! PENDING REQUEST ROLE
  //============================================================================

  bool get isPendingSender => _accessStatus == 'pending_sender';

  bool get isPendingRecipient => _accessStatus == 'pending';

  //============================================================================
  //! GET INQUIRY
  //============================================================================

  InquiryModel? getInquiry(String inquiryId) {
    return _inquiries[inquiryId];
  }

  //============================================================================
  //! FETCH CONVERSATIONS
  //============================================================================

  Future<void> fetchConversations() async {
    _isLoadingConversations = true;

    _error = null;

    notifyListeners();

    try {
      _conversations = await repository.fetchConversations();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingConversations = false;

      notifyListeners();
    }
  }

  //============================================================================
  //! CHAT ACCESS
  //============================================================================

  Future<void> fetchChatAccessStatus(String chatId) async {
    _error = null;

    try {
      //========================================================================
      //! ACCESS STATUS
      //========================================================================

      _accessStatus = await repository.getChatAccessStatus(chatId);

      //========================================================================
      //! PENDING USER
      //========================================================================

      _pendingUserId = await repository.getPendingUserId(chatId);
    } catch (e) {
      _error = e.toString();
    }

    notifyListeners();
  }

  //============================================================================
  //! ACCEPT CHAT
  //============================================================================

  Future<void> acceptChat(String chatId) async {
    _error = null;

    try {
      //========================================================================
      //! ONLY RECIPIENT CAN ACCEPT
      //========================================================================

      if (!isPendingRecipient) {
        throw Exception('Only the recipient can accept this chat request.');
      }

      await repository.acceptChat(chatId);

      _accessStatus = 'unlocked';

      _pendingUserId = null;

      await fetchConversations();
    } catch (e) {
      _error = e.toString();
    }

    notifyListeners();
  }

  //============================================================================
  //! DECLINE CHAT
  //============================================================================

  Future<void> declineChat(String chatId) async {
    _error = null;

    try {
      //========================================================================
      //! ONLY RECIPIENT CAN DECLINE
      //========================================================================

      if (!isPendingRecipient) {
        throw Exception('Only the recipient can delete this chat request.');
      }

      await repository.declineChat(chatId);

      _accessStatus = 'locked';

      _pendingUserId = null;

      await fetchConversations();
    } catch (e) {
      _error = e.toString();
    }

    notifyListeners();
  }

  //============================================================================
  //! BLOCK CHAT
  //============================================================================

  Future<void> blockChat(String chatId) async {
    _error = null;

    try {
      //========================================================================
      //! ONLY RECIPIENT CAN BLOCK PENDING REQUEST
      //========================================================================

      if (isPending && !isPendingRecipient) {
        throw Exception('Only the recipient can block this chat request.');
      }

      await repository.blockChat(chatId);

      _accessStatus = 'blocked';

      _pendingUserId = null;

      await fetchConversations();
    } catch (e) {
      _error = e.toString();
    }

    notifyListeners();
  }

  //============================================================================
  //! UNBLOCK CHAT
  //============================================================================

  Future<void> unblockChat(String chatId) async {
    _error = null;

    try {
      await repository.unblockChat(chatId);

      //========================================================================
      //! UNBLOCK RETURNS TO LOCKED
      //========================================================================

      _accessStatus = 'locked';

      _pendingUserId = null;

      await fetchConversations();
    } catch (e) {
      _error = e.toString();
    }

    notifyListeners();
  }

  //============================================================================
  //! DELETE CHAT
  //============================================================================

  Future<void> deleteChat(String chatId) async {
    _error = null;

    try {
      await repository.deleteChat(chatId);

      await fetchConversations();
    } catch (e) {
      _error = e.toString();
    }

    notifyListeners();
  }

  //============================================================================
  //! FETCH MESSAGES
  //============================================================================

  Future<void> fetchMessages(String chatId) async {
    _isLoadingMessages = true;

    _error = null;

    notifyListeners();

    try {
      //========================================================================
      //! FETCH MESSAGES
      //========================================================================

      _messages = await repository.fetchMessages(chatId);

      //========================================================================
      //! FETCH INQUIRIES
      //========================================================================

      for (final message in _messages) {
        if (message.type != MessageType.inquiry) {
          continue;
        }

        final inquiryId = message.inquiryId;

        if (inquiryId == null || inquiryId.isEmpty) {
          continue;
        }

        final inquiry = await inquiryRepository.getById(inquiryId);

        if (inquiry != null) {
          _inquiries[inquiryId] = inquiry;
        }
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingMessages = false;

      notifyListeners();
    }
  }

  //============================================================================
  //! SEND MESSAGE
  //============================================================================

  Future<void> sendMessage({
    required String chatId,
    required String text,
  }) async {
    final trimmedText = text.trim();

    if (trimmedText.isEmpty || _isSending) {
      return;
    }

    _isSending = true;

    _error = null;

    notifyListeners();

    try {
      final message = await repository.sendMessage(
        chatId: chatId,
        text: trimmedText,
      );

      _messages.insert(0, message);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isSending = false;

      notifyListeners();
    }
  }

  //============================================================================
  //! SEND INQUIRY
  //============================================================================

  Future<void> sendInquiry({
    required String landlordId,
    required String propertyId,
    required String propertyName,
    required String roomId,
    required String roomImageUrl,
    required String roomTitle,
    required double roomPrice,
    required int roomCapacity,
    required String roomGenderPreference,
    required String message,
  }) async {
    if (_isSending) {
      return;
    }

    final trimmedMessage = message.trim();

    _isSending = true;

    _error = null;

    notifyListeners();

    try {
      //========================================================================
      //! GET OR CREATE CHAT
      //========================================================================

      final chatId = await repository.getOrCreateChat(
        user2Id: landlordId,
        propertyId: propertyId,
      );

      //========================================================================
      //! CREATE INQUIRY SNAPSHOT
      //========================================================================

      final inquiry = InquiryModel(
        id: '',
        chatId: chatId,

        //======================================================================
        //! PROPERTY SNAPSHOT
        //======================================================================
        propertyName: propertyName,

        //======================================================================
        //! ROOM REFERENCE
        //======================================================================
        roomId: roomId,

        //======================================================================
        //! ROOM SNAPSHOT
        //======================================================================
        roomImageUrl: roomImageUrl,
        roomTitle: roomTitle,
        roomPrice: roomPrice,
        roomCapacity: roomCapacity,
        roomGenderPreference: roomGenderPreference,

        //======================================================================
        //! INQUIRY
        //======================================================================
        message: trimmedMessage,
        status: InquiryStatus.pending,

        createdAt: DateTime.now(),
      );

      //========================================================================
      //! SAVE INQUIRY
      //========================================================================

      final createdInquiry = await inquiryRepository.create(inquiry);

      //========================================================================
      //! STORE INQUIRY LOCALLY
      //========================================================================

      _inquiries[createdInquiry.id] = createdInquiry;

      //========================================================================
      //! CREATE INQUIRY MESSAGE
      //========================================================================

      final messageModel = await repository.sendInquiryMessage(
        chatId: chatId,
        inquiryId: createdInquiry.id,
        text: trimmedMessage.isEmpty ? 'Inquiry' : trimmedMessage,
      );

      _messages.insert(0, messageModel);

      //========================================================================
      //! UPDATE ACCESS STATUS
      //========================================================================

      _accessStatus = await repository.getChatAccessStatus(chatId);

      //========================================================================
      //! UPDATE PENDING USER
      //========================================================================

      _pendingUserId = await repository.getPendingUserId(chatId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isSending = false;

      notifyListeners();
    }
  }

  //============================================================================
  //! CLEAR ERROR
  //============================================================================

  void clearError() {
    _error = null;

    notifyListeners();
  }

  //============================================================================
  //! CLEAR MESSAGES
  //============================================================================

  void clearMessages() {
    _messages = [];

    _accessStatus = null;

    _pendingUserId = null;

    notifyListeners();
  }
}
