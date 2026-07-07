import 'package:equatable/equatable.dart';

import 'package:duda_educational_flutter/features/chat/domain/entities/message.dart';

enum ChatMessagesStatus { initial, loading, success, sending, failure }

class ChatMessagesState extends Equatable {
  const ChatMessagesState({
    this.status = ChatMessagesStatus.initial,
    this.messages = const [],
    this.errorMessage,
  });

  const ChatMessagesState.initial() : this();

  const ChatMessagesState.loading()
      : this(status: ChatMessagesStatus.loading);

  const ChatMessagesState.success(List<Message> messages)
      : this(status: ChatMessagesStatus.success, messages: messages);

  const ChatMessagesState.sending(List<Message> messages)
      : this(status: ChatMessagesStatus.sending, messages: messages);

  const ChatMessagesState.failure(String message)
      : this(status: ChatMessagesStatus.failure, errorMessage: message);

  final ChatMessagesStatus status;
  final List<Message> messages;
  final String? errorMessage;

  ChatMessagesState copyWith({
    ChatMessagesStatus? status,
    List<Message>? messages,
    String? errorMessage,
  }) {
    return ChatMessagesState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, messages, errorMessage];
}
