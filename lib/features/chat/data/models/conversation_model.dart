import 'package:duda_educational_flutter/features/chat/domain/entities/conversation.dart';

class ConversationModel {
  ConversationModel({
    required this.id,
    required this.participantName,
    required this.participantInitials,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.isOnline,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      ConversationModel(
        id: json['id'] as String,
        participantName: json['participantName'] as String,
        participantInitials: json['participantInitials'] as String,
        lastMessage: json['lastMessage'] as String,
        lastMessageTime: json['lastMessageTime'] as String,
        unreadCount: json['unreadCount'] as int,
        isOnline: json['isOnline'] as bool,
      );

  final String id;
  final String participantName;
  final String participantInitials;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;
  final bool isOnline;

  Conversation toEntity() => Conversation(
        id: id,
        participantName: participantName,
        participantInitials: participantInitials,
        lastMessage: lastMessage,
        lastMessageTime: lastMessageTime,
        unreadCount: unreadCount,
        isOnline: isOnline,
      );
}

class ConversationsResponseModel {
  ConversationsResponseModel({required this.conversations});

  factory ConversationsResponseModel.fromJson(Map<String, dynamic> json) =>
      ConversationsResponseModel(
        conversations: (json['conversations'] as List<dynamic>)
            .map((e) => ConversationModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  final List<ConversationModel> conversations;
}
