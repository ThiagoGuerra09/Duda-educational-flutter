import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  const Conversation({
    required this.id,
    required this.participantName,
    required this.participantInitials,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.isOnline,
  });

  final String id;
  final String participantName;
  final String participantInitials;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;
  final bool isOnline;

  @override
  List<Object?> get props => [
        id,
        participantName,
        participantInitials,
        lastMessage,
        lastMessageTime,
        unreadCount,
        isOnline,
      ];
}
