import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/features/chat/domain/entities/conversation.dart';
import 'package:duda_educational_flutter/features/chat/domain/repositories/chat_repository.dart';

@injectable
class GetConversations {
  const GetConversations(this._repository);

  final ChatRepository _repository;

  Future<List<Conversation>> call() => _repository.getConversations();
}
