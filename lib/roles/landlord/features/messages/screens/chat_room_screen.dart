import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/models/chat_model.dart';
import 'package:bh_finder/core/models/inquiry_model.dart';
import 'package:bh_finder/core/models/message_model.dart';

import 'package:bh_finder/roles/landlord/features/messages/repositories/chat_repository.dart';

import 'package:bh_finder/shared/widgets/messages/chat/chat_app_bar.dart';
import 'package:bh_finder/shared/widgets/messages/cards/inquiry_card.dart';
import 'package:bh_finder/shared/widgets/messages/widgets/message_bubble.dart';
import 'package:bh_finder/shared/widgets/messages/widgets/message_input.dart';

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

class _ChatScreenState extends State<ChatRoomScreen> {
  //============================================================================
  //! REPOSITORY
  //============================================================================

  final ChatRepository _repository = ChatRepository();

  //============================================================================
  //! CONTROLLER
  //============================================================================

  final TextEditingController _controller = TextEditingController();

  //============================================================================
  //! STATE
  //============================================================================

  late Future<List<MessageModel>> _messagesFuture;

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _messagesFuture = _repository.fetchMessages(widget.chat.id);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //============================================================================
  //! METHODS
  //============================================================================

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    await _repository.sendMessage(chatId: widget.chat.id, text: text);

    _controller.clear();

    setState(() {
      _messagesFuture = _repository.fetchMessages(widget.chat.id);
    });
  }

  Widget _buildMessages() {
    return FutureBuilder<List<MessageModel>>(
      future: _messagesFuture,

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        final messages = snapshot.data ?? [];

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
      },
    );
  }

  Widget _buildMessage(MessageModel message) {
    if (message.type == MessageType.text) {
      return MessageBubble(message: message);
    }

    if (message.type == MessageType.inquiry) {
      //========================================================================
      // TODO(Backend)
      //! Replace this mock inquiry with the inquiry associated with the message.
      //========================================================================

      return InquiryCard(
        inquiry: const InquiryModel(
          id: "inq_1",
          boardingHouseId: "bh_1",
          boardingHouseName: "Green Haven Boarding House",
          roomId: "room_1",
          roomName: "Room 1A",
          price: "₱2,700 / month",
          genderRule: "Female Only",
          distance: "4 mins from CSU",
          status: InquiryStatus.pending,
        ),

        message: message,
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

      body: Column(
        children: [
          Expanded(child: _buildMessages()),

          MessageInput(controller: _controller, onSend: _sendMessage),
        ],
      ),
    );
  }
}
