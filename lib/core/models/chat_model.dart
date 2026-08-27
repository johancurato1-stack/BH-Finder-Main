//============================================================================
//! CHAT MODEL
//============================================================================

class ChatModel {
  //============================================================================
  //! FIELDS
  //============================================================================

  final String id;

  // Landlord
  final String landlordId;

  final String landlordName;

  final String avatarUrl;

  // Conversation
  final String lastMessage;

  final bool isUnread;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ChatModel({
    required this.id,
    required this.landlordId,
    required this.landlordName,
    required this.avatarUrl,
    required this.lastMessage,
    required this.isUnread,
  });

  //============================================================================
  //! FROM MAP
  //============================================================================

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] ?? '',
      landlordId: map['landlordId'] ?? '',
      landlordName: map['landlordName'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      isUnread: map['isUnread'] ?? false,
    );
  }

  //============================================================================
  //! TO MAP
  //============================================================================

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'landlordId': landlordId,
      'landlordName': landlordName,
      'avatarUrl': avatarUrl,
      'lastMessage': lastMessage,
      'isUnread': isUnread,
    };
  }
}
