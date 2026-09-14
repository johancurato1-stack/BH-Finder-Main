import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/models/chat_model.dart';
import 'package:bh_finder/core/models/message_model.dart';

import 'package:bh_finder/core/repositories/repositories/repositories.dart';
import 'package:bh_finder/core/view_models/chat_view_model.dart';

import 'package:bh_finder/shared/widgets/messages/chat/chat_access_bar.dart';
import 'package:bh_finder/shared/widgets/messages/chat/chat_app_bar.dart';
import 'package:bh_finder/shared/widgets/messages/cards/inquiry_card.dart';
import 'package:bh_finder/shared/widgets/messages/widgets/message_bubble.dart';
import 'package:bh_finder/shared/widgets/messages/widgets/message_input.dart';

//============================================================================
//! CHAT ROOM SCREEN
//============================================================================

class ChatRoomScreen extends StatefulWidget {
  //============================================================================
  //! VARIABLES
  //============================================================================

  final ChatModel chat;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ChatRoomScreen({super.key, required this.chat});

  @override
  State<ChatRoomScreen> createState() => _ChatScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _ChatScreenState extends State<ChatRoomScreen> {
  //============================================================================
  //! VIEW MODEL
  //============================================================================

  late final ChatViewModel _viewModel;

  //============================================================================
  //! CONTROLLER
  //============================================================================

  final TextEditingController _controller = TextEditingController();

  //============================================================================
  //! REALTIME
  //============================================================================

  StreamSubscription<MessageModel>? _messageSubscription;

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    final repositories = Repositories.instance;

    _viewModel = ChatViewModel(
      repository: repositories.chatRepository,
      inquiryRepository: repositories.inquiryRepository,
    );

    _loadChat();
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();

    _viewModel.repository.unsubscribeFromMessages();

    _controller.dispose();

    _viewModel.dispose();

    super.dispose();
  }

  //============================================================================
  //! LOAD CHAT
  //============================================================================

  Future<void> _loadChat() async {
    //==========================================================================
    //! LOAD ACCESS STATUS
    //==========================================================================

    await _viewModel.fetchChatAccessStatus(widget.chat.id);

    //==========================================================================
    //! LOAD MESSAGES
    //==========================================================================

    await _viewModel.fetchMessages(widget.chat.id);

    if (!mounted) {
      return;
    }

    //==========================================================================
    //! REALTIME
    //==========================================================================

    _subscribeToMessages();

    //==========================================================================
    //! MARK MESSAGES AS READ
    //==========================================================================

    await _viewModel.repository.markMessagesAsRead(widget.chat.id);

    //==========================================================================
    //! REFRESH LOCAL MESSAGE STATUS
    //==========================================================================

    await _viewModel.fetchMessages(widget.chat.id);

    if (mounted) {
      setState(() {});
    }
  }

  //============================================================================
  //! REALTIME MESSAGES
  //============================================================================

  void _subscribeToMessages() {
    _messageSubscription?.cancel();

    _messageSubscription = _viewModel.repository.subscribeToMessages(widget.chat.id).listen((
      message,
    ) async {
      if (!mounted) {
        return;
      }

      //========================================================================
      //! FIND EXISTING MESSAGE
      //========================================================================

      final existingIndex = _viewModel.messages.indexWhere(
        (existing) => existing.id == message.id,
      );

      //========================================================================
      //! UPDATE EXISTING MESSAGE
      //========================================================================

      if (existingIndex != -1) {
        _viewModel.messages[existingIndex] = message;
      }
      //========================================================================
      //! ADD NEW MESSAGE
      //========================================================================
      else {
        _viewModel.messages.insert(0, message);
      }

      //========================================================================
      //! MARK INCOMING MESSAGE AS READ
      //========================================================================

      if (!message.isMe) {
        await _viewModel.repository.markMessagesAsRead(widget.chat.id);
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  //============================================================================
  //! SEND MESSAGE
  //============================================================================

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();

    if (text.isEmpty || _viewModel.isSending) {
      return;
    }

    if (!_viewModel.isUnlocked) {
      return;
    }

    await _viewModel.sendMessage(chatId: widget.chat.id, text: text);

    if (!mounted) {
      return;
    }

    if (_viewModel.error != null) {
      _showError(_viewModel.error!);

      _viewModel.clearError();

      return;
    }

    _controller.clear();
  }

  //============================================================================
  //! ACCEPT CHAT
  //============================================================================

  Future<void> _acceptChat() async {
    await _viewModel.acceptChat(widget.chat.id);

    if (!mounted) {
      return;
    }

    if (_viewModel.error != null) {
      _showError(_viewModel.error!);

      _viewModel.clearError();
    }
  }

  //============================================================================
  //! BLOCK CHAT
  //============================================================================

  Future<void> _blockChat() async {
    await _viewModel.blockChat(widget.chat.id);

    if (!mounted) {
      return;
    }

    if (_viewModel.error != null) {
      _showError(_viewModel.error!);

      _viewModel.clearError();
    }
  }

  //============================================================================
  //! UNBLOCK CHAT
  //============================================================================

  Future<void> _unblockChat() async {
    await _viewModel.unblockChat(widget.chat.id);

    if (!mounted) {
      return;
    }

    if (_viewModel.error != null) {
      _showError(_viewModel.error!);

      _viewModel.clearError();
    }
  }

  //============================================================================
  //! ERROR
  //============================================================================

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  //============================================================================
  //! BUILD MESSAGES
  //============================================================================

  Widget _buildMessages() {
    if (_viewModel.isLoadingMessages) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_viewModel.error != null) {
      return Center(
        child: Text(_viewModel.error!, textAlign: TextAlign.center),
      );
    }

    final messages = _viewModel.messages;

    if (messages.isEmpty) {
      return const Center(child: Text('No messages yet.'));
    }

    return ListView.builder(
      reverse: true,

      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      itemCount: messages.length,

      itemBuilder: (context, index) {
        return _buildMessage(messages[index]);
      },
    );
  }

  //============================================================================
  //! BUILD MESSAGE
  //============================================================================

  Widget _buildMessage(MessageModel message) {
    //==========================================================================
    //! TEXT MESSAGE
    //==========================================================================

    if (message.type == MessageType.text) {
      return MessageBubble(message: message);
    }

    //==========================================================================
    //! INQUIRY MESSAGE
    //==========================================================================

    if (message.type == MessageType.inquiry) {
      final inquiryId = message.inquiryId;

      if (inquiryId == null || inquiryId.isEmpty) {
        return const SizedBox.shrink();
      }

      final inquiry = _viewModel.getInquiry(inquiryId);

      if (inquiry == null) {
        return const SizedBox.shrink();
      }

      return InquiryCard(inquiry: inquiry, message: message);
    }

    return const SizedBox.shrink();
  }

  //============================================================================
  //! BUILD PENDING SENDER BAR
  //============================================================================

  Widget _buildPendingSenderBar() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(16, 14, 16, 30),

      color: AppColors.white,

      child: const Text(
        'Your inquiry is pending. You can message once the chat is unlocked.',
        textAlign: TextAlign.center,

        style: TextStyle(
          color: AppColors.secondary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  //============================================================================
  //! BUILD BOTTOM BAR
  //============================================================================

  Widget _buildBottomBar() {
    //==========================================================================
    //! USE VIEW MODEL STATUS
    //==========================================================================

    final accessStatus = _viewModel.accessStatus ?? widget.chat.accessStatus;

    //==========================================================================
    //! UNLOCKED
    //==========================================================================

    if (accessStatus == 'unlocked') {
      return MessageInput(controller: _controller, onSend: _sendMessage);
    }

    //==========================================================================
    //! PENDING — RECIPIENT
    //==========================================================================

    if (accessStatus == 'pending') {
      return ChatAccessBar(
        accessStatus: 'pending',
        onBlock: _blockChat,
        onAccept: _acceptChat,
      );
    }

    //==========================================================================
    //! PENDING — SENDER
    //==========================================================================

    if (accessStatus == 'pending_sender') {
      return _buildPendingSenderBar();
    }

    //==========================================================================
    //! BLOCKED
    //==========================================================================

    if (accessStatus == 'blocked') {
      return ChatAccessBar(accessStatus: 'blocked', onUnblock: _unblockChat);
    }

    //==========================================================================
    //! LOCKED
    //==========================================================================

    if (accessStatus == 'locked') {
      return Container(
        width: double.infinity,

        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

        color: AppColors.white,

        child: const Text(
          'This chat is locked. Send an inquiry to request access.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: ChatAppBar(chat: widget.chat),

      body: AnimatedBuilder(
        animation: _viewModel,

        builder: (context, _) {
          return Column(
            children: [
              //================================================================
              //! MESSAGES
              //================================================================
              Expanded(child: _buildMessages()),

              //================================================================
              //! ACCESS BAR / MESSAGE INPUT
              //================================================================
              _buildBottomBar(),
            ],
          );
        },
      ),
    );
  }
}
