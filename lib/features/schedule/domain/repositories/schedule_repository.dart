import 'package:duda_educational_flutter/features/schedule/domain/entities/calendar_event.dart';

abstract class ScheduleRepository {
  Future<List<CalendarEvent>> getCalendarEvents();
}
