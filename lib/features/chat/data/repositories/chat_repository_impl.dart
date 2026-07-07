import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/cache/memory_cache.dart';
import 'package:duda_educational_flutter/core/constants/app_constants.dart';
import 'package:duda_educational_flutter/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:duda_educational_flutter/features/chat/domain/entities/conversation.dart';
import 'package:duda_educational_flutter/features/chat/domain/entities/message.dart';
import 'package:duda_educational_flutter/features/chat/domain/repositories/chat_repository.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._dataSource, this._cache);

  final ChatRemoteDataSource _dataSource;
  final MemoryCache _cache;

  static const _conversationsCacheKey = 'conversations';

  @override
  Future<List<Conversation>> getConversations() async {
    final cached = _cache.get<List<Conversation>>(_conversationsCacheKey);
    if (cached != null) return cached;

    final models = await _dataSource.getConversations();
    final entities = models.map((m) => m.toEntity()).toList();
    _cache.set(_conversationsCacheKey, entities, ttl: AppConstants.cacheTtl);
    return entities;
  }

  @override
  Future<List<Message>> getMessages(String conversationId) async {
    final cacheKey = 'messages_$conversationId';
    final cached = _cache.get<List<Message>>(cacheKey);
    if (cached != null) return cached;

    final models = await _dataSource.getMessages(conversationId);
    final entities = models.map((m) => m.toEntity()).toList();
    _cache.set(cacheKey, entities, ttl: AppConstants.cacheTtl);
    return entities;
  }

  @override
  Future<Message> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    final model = await _dataSource.sendMessage(
      conversationId: conversationId,
      content: content,
    );
    final entity = model.toEntity();

    final cacheKey = 'messages_$conversationId';
    final cached = _cache.get<List<Message>>(cacheKey) ?? [];
    _cache.set(cacheKey, [...cached, entity]);

    return entity;
  }
}
