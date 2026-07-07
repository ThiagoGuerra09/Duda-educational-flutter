import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:duda_educational_flutter/features/schedule/domain/entities/calendar_event.dart';
import 'package:duda_educational_flutter/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:duda_educational_flutter/features/schedule/presentation/cubit/schedule_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_app_bar.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_empty_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_error_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_loading.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_scaffold.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';
import 'package:duda_educational_flutter/shared/widgets/schedule_card.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  void initState() {
    super.initState();
    context.read<ScheduleCubit>().loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return DudaScaffold(
      appBar: const DudaAppBar(title: 'Agenda'),
      body: BlocBuilder<ScheduleCubit, ScheduleState>(
        builder: (context, state) {
          return switch (state.status) {
            ScheduleStatus.initial || ScheduleStatus.loading =>
              const DudaLoading.skeleton(itemCount: 3),
            ScheduleStatus.failure => DudaErrorState(
                message: state.errorMessage ?? 'Erro ao carregar agenda',
                onRetry: () => context.read<ScheduleCubit>().loadEvents(),
              ),
            ScheduleStatus.success => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TableCalendar<CalendarEvent>(
                    firstDay: DateTime.utc(2026, 1, 1),
                    lastDay: DateTime.utc(2026, 12, 31),
                    focusedDay: state.selectedDay.focusedDay ?? DateTime.now(),
                    selectedDayPredicate: (day) =>
                        isSameDay(state.selectedDay.day, day),
                    eventLoader: (day) => state.events.where((event) {
                      return isSameDay(event.date, day);
                    }).toList(),
                    onDaySelected: (selectedDay, focusedDay) {
                      context
                          .read<ScheduleCubit>()
                          .selectDay(selectedDay, focusedDay);
                    },
                    calendarStyle: const CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      markerDecoration: BoxDecoration(
                        color: AppColors.accentPink,
                        shape: BoxShape.circle,
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(AppSpacing.lg),
                    child: DudaText.label('EVENTOS DO DIA'),
                  ),
                  Expanded(
                    child: state.eventsForSelectedDay.isEmpty
                        ? const DudaEmptyState(
                            message: 'Nenhum evento para este dia.',
                            icon: Icons.event_busy,
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                            ),
                            itemCount: state.eventsForSelectedDay.length,
                            itemBuilder: (context, index) {
                              final event = state.eventsForSelectedDay[index];
                              return ScheduleCard(
                                title: event.title,
                                startTime: event.startTime,
                                endTime: event.endTime,
                                location: event.location,
                                type: event.type,
                              );
                            },
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
