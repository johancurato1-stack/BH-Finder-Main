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

  //============================================================================
  //! GETTERS
  //============================================================================

  List<ChatModel> get conversations => _conversations;

  List<MessageModel> get messages => _messages;

  bool get isLoadingConversations => _isLoadingConversations;

  bool get isLoadingMessages => _isLoadingMessages;

  bool get isSending => _isSending;

  String? get error => _error;

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
  //! FETCH MESSAGES
  //============================================================================

  Future<void> fetchMessages(String chatId) async {
    _isLoadingMessages = true;

    _error = null;

    notifyListeners();

    try {
      _messages = await repository.fetchMessages(chatId);

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
    required String roomId,
    required String roomTitle,
    required double roomPrice,
    required int roomCapacity,
    required GenderPreference genderPreference,
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
      final chatId = await repository.getOrCreateChat(landlordId: landlordId);

      final now = DateTime.now();

      final inquiry = InquiryModel(
        id: '',
        chatId: chatId,
        tenantId: repository.currentUserId,
        landlordId: landlordId,
        propertyId: propertyId,
        roomId: roomId,
        roomTitle: roomTitle,
        roomPrice: roomPrice,
        roomCapacity: roomCapacity,
        genderPreference: genderPreference,
        message: trimmedMessage,
        status: InquiryStatus.pending,
        createdAt: now,
        updatedAt: now,
      );

      final messageModel = await repository.sendInquiry(inquiry: inquiry);

      _messages.insert(0, messageModel);
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

    notifyListeners();
  }
}
