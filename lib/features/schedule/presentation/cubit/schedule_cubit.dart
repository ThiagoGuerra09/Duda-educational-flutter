import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/errors/exceptions.dart';
import 'package:duda_educational_flutter/core/errors/failures.dart';
import 'package:duda_educational_flutter/features/schedule/domain/usecases/get_calendar_events.dart';
import 'package:duda_educational_flutter/features/schedule/presentation/cubit/schedule_state.dart';

@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit(this._getCalendarEvents) : super(const ScheduleState.initial());

  final GetCalendarEvents _getCalendarEvents;

  Future<void> loadEvents() async {
    emit(const ScheduleState.loading());
    try {
      final events = await _getCalendarEvents();
      final today = DateTime.now();
      emit(ScheduleState.success(
        events: events,
        selectedDay: ScheduleSelectedDay(
          day: today,
          focusedDay: today,
        ),
      ));
    } on ServerException catch (e) {
      emit(ScheduleState.failure(e.message));
    } on Failure catch (e) {
      emit(ScheduleState.failure(e.message));
    } catch (e) {
      emit(ScheduleState.failure(e.toString()));
    }
  }

  void selectDay(DateTime selectedDay, DateTime focusedDay) {
    emit(state.copyWith(
      selectedDay: ScheduleSelectedDay(
        day: selectedDay,
        focusedDay: focusedDay,
      ),
    ));
  }
}
