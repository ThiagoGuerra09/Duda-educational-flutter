import 'package:equatable/equatable.dart';

import 'package:duda_educational_flutter/features/chat/domain/entities/conversation.dart';

enum ChatListStatus { initial, loading, success, failure }

class ChatListState extends Equatable {
  const ChatListState({
    this.status = ChatListStatus.initial,
    this.conversations = const [],
    this.errorMessage,
  });

  const ChatListState.initial() : this();

  const ChatListState.loading() : this(status: ChatListStatus.loading);

  const ChatListState.success(List<Conversation> conversations)
      : this(status: ChatListStatus.success, conversations: conversations);

  const ChatListState.failure(String message)
      : this(status: ChatListStatus.failure, errorMessage: message);

  final ChatListStatus status;
  final List<Conversation> conversations;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, conversations, errorMessage];
}
