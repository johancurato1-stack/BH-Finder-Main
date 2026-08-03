import 'package:bh_finder/core/models/chat_model.dart';

class MockChat {
  MockChat._();

  //============================================================================
  //! CONVERSATIONS
  //============================================================================

  static final List<ChatModel> conversations = [
    ChatModel(
      id: "chat_1",

      landlordId: "landlord_1",
      landlordName: "Maria Santos",
      avatarUrl:
          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=150&auto=format&fit=crop",
      responseTime: "Usually replies in 30 mins",
      isOnline: true,

      propertyId: "property_1",
      propertyTitle: "Green Haven Boarding House",

      lastMessage:
          "Hello! Yes, the female slot is still available for viewing tomorrow.",
      timeStamp: "9:41 AM",
      isUnread: true,
    ),

    ChatModel(
      id: "chat_2",

      landlordId: "landlord_2",
      landlordName: "Juan Dela Cruz",
      avatarUrl:
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=150&auto=format&fit=crop",
      responseTime: "Usually replies in 1 hour",
      isOnline: false,

      propertyId: "property_2",
      propertyTitle: "Blessed Home Boarding House",

      lastMessage:
          "The reservation fee is non-refundable, but it deducts from your first month.",
      timeStamp: "Yesterday",
      isUnread: false,
    ),
  ];
}
