//============================================================================
//! CHAT MODEL
//============================================================================

class ChatModel {
  //============================================================================
  //! FIELDS
  //============================================================================

  final String id;

  // Participant
  final String landlordId;

  final String landlordName;

  final String avatarUrl;

  final bool isOnline;

  final DateTime? lastSeenAt;

  // Conversation
  final String lastMessage;

  final DateTime? lastMessageAt;

  final int unreadCount;

  // Chat Access
  final String accessStatus;

  final String? pendingUserId;

  final DateTime? pendingSince;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ChatModel({
    required this.id,
    required this.landlordId,
    required this.landlordName,
    required this.avatarUrl,
    required this.isOnline,
    required this.lastSeenAt,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.unreadCount,
    required this.accessStatus,
    required this.pendingUserId,
    required this.pendingSince,
  });

  //============================================================================
  //! IS UNREAD
  //============================================================================

  bool get isUnread => unreadCount > 0;

  //============================================================================
  //! IS LOCKED
  //============================================================================

  bool get isLocked => accessStatus == 'locked';

  //============================================================================
  //! IS PENDING
  //============================================================================

  bool get isPending =>
      accessStatus == 'pending' || accessStatus == 'pending_sender';

  //============================================================================
  //! IS UNLOCKED
  //============================================================================

  bool get isUnlocked => accessStatus == 'unlocked';

  //============================================================================
  //! IS BLOCKED
  //============================================================================

  bool get isBlocked => accessStatus == 'blocked';

  //============================================================================
  //! FROM MAP
  //============================================================================

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] ?? '',
      landlordId: map['landlordId'] ?? '',
      landlordName: map['landlordName'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
      isOnline: map['isOnline'] ?? false,

      lastSeenAt: map['lastSeenAt'] != null
          ? DateTime.tryParse(map['lastSeenAt'].toString())
          : null,

      lastMessage: map['lastMessage'] ?? '',

      lastMessageAt: map['lastMessageAt'] != null
          ? DateTime.tryParse(map['lastMessageAt'].toString())
          : null,

      unreadCount: map['unreadCount'] ?? 0,

      accessStatus: map['accessStatus'] ?? 'locked',

      pendingUserId: map['pendingUserId'],

      pendingSince: map['pendingSince'] != null
          ? DateTime.tryParse(map['pendingSince'].toString())
          : null,
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
      'isOnline': isOnline,
      'lastSeenAt': lastSeenAt?.toIso8601String(),
      'lastMessage': lastMessage,
      'lastMessageAt': lastMessageAt?.toIso8601String(),
      'unreadCount': unreadCount,
      'accessStatus': accessStatus,
      'pendingUserId': pendingUserId,
      'pendingSince': pendingSince?.toIso8601String(),
    };
  }
}
