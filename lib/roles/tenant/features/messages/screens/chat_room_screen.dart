import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/models/chat_model.dart';
import 'package:bh_finder/core/models/message_model.dart';

import 'package:bh_finder/core/repositories/supabase/supabase_inquiry_repository.dart';
import 'package:bh_finder/core/repositories/supabase/supabase_chat_repository.dart';
import 'package:bh_finder/core/view_models/chat_view_model.dart';

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
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  //============================================================================
  //! VIEW MODEL
  //============================================================================

  late final ChatViewModel _viewModel;

  //============================================================================
  //! CONTROLLER
  //============================================================================

  final TextEditingController _controller = TextEditingController();

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _viewModel = ChatViewModel(
      repository: SupabaseChatRepository(),
      inquiryRepository: SupabaseInquiryRepository(),
    );

    _viewModel.fetchMessages(widget.chat.id);
  }

  @override
  void dispose() {
    _controller.dispose();
    _viewModel.dispose();

    super.dispose();
  }

  //============================================================================
  //! SEND MESSAGE
  //============================================================================

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();

    if (text.isEmpty || _viewModel.isSending) {
      return;
    }

    await _viewModel.sendMessage(chatId: widget.chat.id, text: text);

    if (_viewModel.error == null) {
      _controller.clear();
    }
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
    //---------------------------------------------------------------------------
    //! TEXT MESSAGE
    //---------------------------------------------------------------------------

    if (message.type == MessageType.text) {
      return MessageBubble(message: message);
    }

    //---------------------------------------------------------------------------
    //! INQUIRY MESSAGE
    //---------------------------------------------------------------------------

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
              Expanded(child: _buildMessages()),

              MessageInput(controller: _controller, onSend: _sendMessage),
            ],
          );
        },
      ),
    );
  }
}
