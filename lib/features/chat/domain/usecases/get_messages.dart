import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/features/chat/domain/entities/message.dart';
import 'package:duda_educational_flutter/features/chat/domain/repositories/chat_repository.dart';

@injectable
class GetMessages {
  const GetMessages(this._repository);

  final ChatRepository _repository;

  Future<List<Message>> call(String conversationId) =>
      _repository.getMessages(conversationId);
}
