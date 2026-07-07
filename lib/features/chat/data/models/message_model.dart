import 'package:duda_educational_flutter/features/chat/domain/entities/message.dart';

class MessageModel {
  MessageModel({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.timestamp,
    required this.isMe,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json['id'] as String,
        senderId: json['senderId'] as String,
        senderName: json['senderName'] as String,
        content: json['content'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
        isMe: json['isMe'] as bool,
      );

  final String id;
  final String senderId;
  final String senderName;
  final String content;
  final DateTime timestamp;
  final bool isMe;

  Message toEntity() => Message(
        id: id,
        senderId: senderId,
        senderName: senderName,
        content: content,
        timestamp: timestamp,
        isMe: isMe,
      );
}

class MessagesResponseModel {
  MessagesResponseModel({required this.messages});

  factory MessagesResponseModel.fromJson(Map<String, dynamic> json) =>
      MessagesResponseModel(
        messages: (json['messages'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            (value as List<dynamic>)
                .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        ),
      );

  final Map<String, List<MessageModel>> messages;
}
