import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/errors/exceptions.dart';
import 'package:duda_educational_flutter/core/errors/failures.dart';
import 'package:duda_educational_flutter/features/chat/domain/usecases/get_messages.dart';
import 'package:duda_educational_flutter/features/chat/domain/usecases/send_message.dart';
import 'package:duda_educational_flutter/features/chat/presentation/cubit/chat_messages_state.dart';

@injectable
class ChatMessagesCubit extends Cubit<ChatMessagesState> {
  ChatMessagesCubit(this._getMessages, this._sendMessage)
      : super(const ChatMessagesState.initial());

  final GetMessages _getMessages;
  final SendMessage _sendMessage;

  Future<void> loadMessages(String conversationId) async {
    emit(const ChatMessagesState.loading());
    try {
      final messages = await _getMessages(conversationId);
      emit(ChatMessagesState.success(messages));
    } on ServerException catch (e) {
      emit(ChatMessagesState.failure(e.message));
    } on Failure catch (e) {
      emit(ChatMessagesState.failure(e.message));
    } catch (e) {
      emit(ChatMessagesState.failure(e.toString()));
    }
  }

  Future<void> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    if (content.trim().isEmpty) return;

    emit(ChatMessagesState.sending(state.messages));
    try {
      final message = await _sendMessage(
        conversationId: conversationId,
        content: content.trim(),
      );
      emit(ChatMessagesState.success([...state.messages, message]));
    } on ServerException catch (e) {
      emit(ChatMessagesState.failure(e.message));
    } on Failure catch (e) {
      emit(ChatMessagesState.failure(e.message));
    } catch (e) {
      emit(ChatMessagesState.failure(e.toString()));
    }
  }
}
