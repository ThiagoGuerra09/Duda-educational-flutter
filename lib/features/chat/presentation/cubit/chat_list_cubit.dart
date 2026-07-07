import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/errors/exceptions.dart';
import 'package:duda_educational_flutter/core/errors/failures.dart';
import 'package:duda_educational_flutter/features/chat/domain/usecases/get_conversations.dart';
import 'package:duda_educational_flutter/features/chat/presentation/cubit/chat_list_state.dart';

@injectable
class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit(this._getConversations) : super(const ChatListState.initial());

  final GetConversations _getConversations;

  Future<void> loadConversations() async {
    emit(const ChatListState.loading());
    try {
      final conversations = await _getConversations();
      emit(ChatListState.success(conversations));
    } on ServerException catch (e) {
      emit(ChatListState.failure(e.message));
    } on Failure catch (e) {
      emit(ChatListState.failure(e.message));
    } catch (e) {
      emit(ChatListState.failure(e.toString()));
    }
  }
}
