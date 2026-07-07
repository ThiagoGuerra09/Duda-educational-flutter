import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:duda_educational_flutter/features/chat/presentation/cubit/chat_messages_cubit.dart';
import 'package:duda_educational_flutter/features/chat/presentation/cubit/chat_messages_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_app_bar.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_error_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_list_tile.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_loading.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_scaffold.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_textfield.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';
import 'package:duda_educational_flutter/shared/widgets/message_bubble.dart';

class ChatMessagesPage extends StatefulWidget {
  const ChatMessagesPage({
    required this.conversationId,
    required this.participantName,
    super.key,
  });

  final String conversationId;
  final String participantName;

  @override
  State<ChatMessagesPage> createState() => _ChatMessagesPageState();
}

class _ChatMessagesPageState extends State<ChatMessagesPage> {
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatMessagesCubit>().loadMessages(widget.conversationId);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final content = _messageController.text;
    if (content.trim().isEmpty) return;

    context.read<ChatMessagesCubit>().sendMessage(
          conversationId: widget.conversationId,
          content: content,
        );
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return DudaScaffold(
      appBar: DudaAppBar(title: widget.participantName),
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<ChatMessagesCubit, ChatMessagesState>(
        builder: (context, state) {
          return switch (state.status) {
            ChatMessagesStatus.initial || ChatMessagesStatus.loading =>
              const DudaLoading.skeleton(itemCount: 5),
            ChatMessagesStatus.failure => DudaErrorState(
                message: state.errorMessage ?? 'Erro ao carregar mensagens',
                onRetry: () => context
                    .read<ChatMessagesCubit>()
                    .loadMessages(widget.conversationId),
              ),
            ChatMessagesStatus.success ||
            ChatMessagesStatus.sending =>
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[
                            state.messages.length - 1 - index];
                        return MessageBubble(
                          content: message.content,
                          time: DateFormat('HH:mm').format(message.timestamp),
                          isMe: message.isMe,
                          senderName: message.senderName,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Row(
                      children: [
                        Expanded(
                          child: DudaTextField(
                            hint: 'Digite sua mensagem...',
                            controller: _messageController,
                            onChanged: (_) {},
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        DudaIconButton(
                          icon: Icons.send,
                          onPressed: state.status == ChatMessagesStatus.sending
                              ? null
                              : _sendMessage,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          };
        },
      ),
    );
  }
}
