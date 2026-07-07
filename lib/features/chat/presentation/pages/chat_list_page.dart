import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:duda_educational_flutter/features/chat/domain/entities/conversation.dart';
import 'package:duda_educational_flutter/features/chat/presentation/cubit/chat_list_cubit.dart';
import 'package:duda_educational_flutter/features/chat/presentation/cubit/chat_list_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_app_bar.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_empty_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_error_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_loading.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_scaffold.dart';
import 'package:duda_educational_flutter/shared/widgets/chat_tile.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key, this.onConversationTap});

  final ValueChanged<Conversation>? onConversationTap;

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ChatListCubit>().loadConversations();
  }

  @override
  Widget build(BuildContext context) {
    return DudaScaffold(
      appBar: const DudaAppBar(title: 'Chat'),
      body: BlocBuilder<ChatListCubit, ChatListState>(
        builder: (context, state) {
          return switch (state.status) {
            ChatListStatus.initial || ChatListStatus.loading =>
              const DudaLoading.skeleton(itemCount: 4),
            ChatListStatus.failure => DudaErrorState(
                message: state.errorMessage ?? 'Erro ao carregar conversas',
                onRetry: () =>
                    context.read<ChatListCubit>().loadConversations(),
              ),
            ChatListStatus.success when state.conversations.isEmpty =>
              const DudaEmptyState(
                message: 'Nenhuma conversa encontrada.',
                icon: Icons.chat_bubble_outline,
              ),
            ChatListStatus.success => ListView.builder(
                itemCount: state.conversations.length,
                itemBuilder: (context, index) {
                  final conversation = state.conversations[index];
                  return ChatTile(
                    participantName: conversation.participantName,
                    participantInitials: conversation.participantInitials,
                    lastMessage: conversation.lastMessage,
                    lastMessageTime: conversation.lastMessageTime,
                    unreadCount: conversation.unreadCount,
                    isOnline: conversation.isOnline,
                    onTap: () {
                      widget.onConversationTap?.call(conversation);
                      context.push(
                        '/chat/${conversation.id}?name=${Uri.encodeComponent(conversation.participantName)}',
                      );
                    },
                  );
                },
              ),
          };
        },
      ),
    );
  }
}
