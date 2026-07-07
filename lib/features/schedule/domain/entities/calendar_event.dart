import 'package:equatable/equatable.dart';

class CalendarEvent extends Equatable {
  const CalendarEvent({
    required this.id,
    required this.title,
    required this.type,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.location,
  });

  final String id;
  final String title;
  final String type;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String location;

  @override
  List<Object?> get props =>
      [id, title, type, date, startTime, endTime, location];
}
