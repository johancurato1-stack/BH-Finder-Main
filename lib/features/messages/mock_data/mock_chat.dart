import 'package:bh_finder/features/messages/models/chat_model.dart';

final List<ChatModel> landlordConversations = [
  const ChatModel(
    id: '1',
    landlordName: 'Maria Santos',
    propertyTitle: 'Green Haven Boarding House',
    lastMessage:
        'Hello! Yes, the female slot is still available for viewing tomorrow.',
    timeStamp: '9:41 AM',
    avatarUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=150&auto=format&fit=crop',
    isUnread: true,
  ),
  const ChatModel(
    id: '2',
    landlordName: 'Juan Dela Cruz',
    propertyTitle: 'Blessed Home Boarding House',
    lastMessage:
        'The reservation fee is non-refundable, but it deducts from your first month.',
    timeStamp: 'Yesterday',
    avatarUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=150&auto=format&fit=crop',
  ),
];
