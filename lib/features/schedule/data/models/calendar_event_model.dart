import 'package:duda_educational_flutter/features/schedule/domain/entities/calendar_event.dart';

class CalendarEventModel {
  CalendarEventModel({
    required this.id,
    required this.title,
    required this.type,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.location,
  });

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) =>
      CalendarEventModel(
        id: json['id'] as String,
        title: json['title'] as String,
        type: json['type'] as String,
        date: DateTime.parse(json['date'] as String),
        startTime: json['startTime'] as String,
        endTime: json['endTime'] as String,
        location: json['location'] as String,
      );

  final String id;
  final String title;
  final String type;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String location;

  CalendarEvent toEntity() => CalendarEvent(
        id: id,
        title: title,
        type: type,
        date: date,
        startTime: startTime,
        endTime: endTime,
        location: location,
      );
}

class CalendarResponseModel {
  CalendarResponseModel({required this.events});

  factory CalendarResponseModel.fromJson(Map<String, dynamic> json) =>
      CalendarResponseModel(
        events: (json['events'] as List<dynamic>)
            .map((e) => CalendarEventModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  final List<CalendarEventModel> events;
}
