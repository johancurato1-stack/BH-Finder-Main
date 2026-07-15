import 'package:flutter/material.dart';

enum MessageType { text, inquiry, system }

enum MessageStatus { sending, sent, delivered, seen }

class MessageModel {
  //============================================================================
  //! VARIABLES
  //============================================================================

  final String id;
  final String chatId;
  final String senderId;
  final String text;
  final bool isMe;

  final MessageType type;
  final MessageStatus status;

  final DateTime sentAt;

  final String? inquiryId;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.isMe,
    required this.type,
    required this.status,
    required this.sentAt,

    this.inquiryId,
  });

  //============================================================================
  //! GETTERS
  //============================================================================

  String get formattedTime {
    final hour = sentAt.hour;
    final minute = sentAt.minute.toString().padLeft(2, '0');

    final suffix = hour >= 12 ? 'PM' : 'AM';

    final displayHour = hour % 12 == 0 ? 12 : hour % 12;

    return '$displayHour:$minute $suffix';
  }

  IconData get statusIcon {
    switch (status) {
      case MessageStatus.sending:
        return Icons.access_time;

      case MessageStatus.sent:
        return Icons.check;

      case MessageStatus.delivered:
        return Icons.done_all;

      case MessageStatus.seen:
        return Icons.done_all;
    }
  }

  Color get statusColor {
    switch (status) {
      case MessageStatus.seen:
        return Colors.blue;

      default:
        return Colors.grey;
    }
  }
}
