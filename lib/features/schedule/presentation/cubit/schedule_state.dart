import 'package:equatable/equatable.dart';

import 'package:duda_educational_flutter/features/schedule/domain/entities/calendar_event.dart';

enum ScheduleStatus { initial, loading, success, failure }

class ScheduleState extends Equatable {
  const ScheduleState({
    this.status = ScheduleStatus.initial,
    this.events = const [],
    this.selectedDay = const ScheduleSelectedDay(),
    this.errorMessage,
  });

  const ScheduleState.initial() : this();

  const ScheduleState.loading()
      : this(status: ScheduleStatus.loading);

  const ScheduleState.success({
    required List<CalendarEvent> events,
    ScheduleSelectedDay? selectedDay,
  }) : this(
          status: ScheduleStatus.success,
          events: events,
          selectedDay: selectedDay ?? const ScheduleSelectedDay(),
        );

  const ScheduleState.failure(String message)
      : this(status: ScheduleStatus.failure, errorMessage: message);

  final ScheduleStatus status;
  final List<CalendarEvent> events;
  final ScheduleSelectedDay selectedDay;
  final String? errorMessage;

  List<CalendarEvent> get eventsForSelectedDay {
    if (selectedDay.day == null) return [];
    return events.where((event) {
      return event.date.year == selectedDay.day!.year &&
          event.date.month == selectedDay.day!.month &&
          event.date.day == selectedDay.day!.day;
    }).toList();
  }

  ScheduleState copyWith({
    ScheduleStatus? status,
    List<CalendarEvent>? events,
    ScheduleSelectedDay? selectedDay,
    String? errorMessage,
  }) {
    return ScheduleState(
      status: status ?? this.status,
      events: events ?? this.events,
      selectedDay: selectedDay ?? this.selectedDay,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, events, selectedDay, errorMessage];
}

class ScheduleSelectedDay extends Equatable {
  const ScheduleSelectedDay({this.day, this.focusedDay});

  final DateTime? day;
  final DateTime? focusedDay;

  @override
  List<Object?> get props => [day, focusedDay];
}
