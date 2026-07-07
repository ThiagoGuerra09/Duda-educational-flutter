import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/features/chat/domain/entities/message.dart';
import 'package:duda_educational_flutter/features/chat/domain/repositories/chat_repository.dart';

@injectable
class SendMessage {
  const SendMessage(this._repository);

  final ChatRepository _repository;

  Future<Message> call({
    required String conversationId,
    required String content,
  }) =>
      _repository.sendMessage(
        conversationId: conversationId,
        content: content,
      );
}
