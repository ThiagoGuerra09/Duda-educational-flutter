import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/features/schedule/domain/entities/calendar_event.dart';
import 'package:duda_educational_flutter/features/schedule/domain/repositories/schedule_repository.dart';

@injectable
class GetCalendarEvents {
  const GetCalendarEvents(this._repository);

  final ScheduleRepository _repository;

  Future<List<CalendarEvent>> call() => _repository.getCalendarEvents();
}
