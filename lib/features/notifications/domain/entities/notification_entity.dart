import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.date,
    required this.isRead,
  });

  final String id;
  final String title;
  final String body;
  final String category;
  final DateTime date;
  final bool isRead;

  @override
  List<Object?> get props => [id, title, body, category, date, isRead];
}
