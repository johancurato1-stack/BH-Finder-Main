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
  final String responseTime;
  final bool isOnline;

  // Property
  final String propertyId;
  final String propertyTitle;

  // Conversation
  final String lastMessage;
  final String timeStamp;
  final bool isUnread;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ChatModel({
    required this.id,
    required this.landlordId,
    required this.landlordName,
    required this.avatarUrl,
    required this.responseTime,
    required this.isOnline,
    required this.propertyId,
    required this.propertyTitle,
    required this.lastMessage,
    required this.timeStamp,
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
      responseTime: map['responseTime'] ?? '',
      isOnline: map['isOnline'] ?? false,
      propertyId: map['propertyId'] ?? '',
      propertyTitle: map['propertyTitle'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      timeStamp: map['timeStamp'] ?? '',
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
      'responseTime': responseTime,
      'isOnline': isOnline,
      'propertyId': propertyId,
      'propertyTitle': propertyTitle,
      'lastMessage': lastMessage,
      'timeStamp': timeStamp,
      'isUnread': isUnread,
    };
  }
}
