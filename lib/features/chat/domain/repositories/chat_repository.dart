import 'package:duda_educational_flutter/features/chat/domain/entities/conversation.dart';
import 'package:duda_educational_flutter/features/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Future<List<Conversation>> getConversations();

  Future<List<Message>> getMessages(String conversationId);

  Future<Message> sendMessage({
    required String conversationId,
    required String content,
  });
}
