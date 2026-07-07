import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import 'package:duda_educational_flutter/core/constants/app_constants.dart';
import 'package:duda_educational_flutter/core/errors/exceptions.dart';
import 'package:duda_educational_flutter/features/chat/data/models/conversation_model.dart';
import 'package:duda_educational_flutter/features/chat/data/models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ConversationModel>> getConversations();

  Future<List<MessageModel>> getMessages(String conversationId);

  Future<MessageModel> sendMessage({
    required String conversationId,
    required String content,
  });
}

@LazySingleton(as: ChatRemoteDataSource)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl(this._dio);

  final Dio _dio;
  final _uuid = const Uuid();

  @override
  Future<List<ConversationModel>> getConversations() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(ApiEndpoints.chat);
      final model = ConversationsResponseModel.fromJson(response.data!);
      return model.conversations;
    } on DioException {
      throw const ServerException('Erro ao carregar conversas');
    }
  }

  @override
  Future<List<MessageModel>> getMessages(String conversationId) async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>(ApiEndpoints.messages);
      final model = MessagesResponseModel.fromJson(response.data!);
      return model.messages[conversationId] ?? [];
    } on DioException {
      throw const ServerException('Erro ao carregar mensagens');
    }
  }

  @override
  Future<MessageModel> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    return MessageModel(
      id: _uuid.v4(),
      senderId: 'prof-001',
      senderName: 'Eu',
      content: content,
      timestamp: DateTime.now(),
      isMe: true,
    );
  }
}
