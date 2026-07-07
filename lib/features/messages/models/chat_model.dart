class ChatModel {
  final String id;
  final String landlordName;
  final String propertyTitle;
  final String lastMessage;
  final String timeStamp;
  final String avatarUrl;
  final bool isUnread;

  const ChatModel({
    required this.id,
    required this.landlordName,
    required this.propertyTitle,
    required this.lastMessage,
    required this.timeStamp,
    required this.avatarUrl,
    this.isUnread = false,
  });
}
