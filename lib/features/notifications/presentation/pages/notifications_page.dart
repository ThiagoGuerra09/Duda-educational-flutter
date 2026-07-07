import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:duda_educational_flutter/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:duda_educational_flutter/features/notifications/presentation/cubit/notifications_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_app_bar.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_chip.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_empty_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_error_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_loading.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_scaffold.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';
import 'package:duda_educational_flutter/shared/widgets/notification_card.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  static const _filters = [
    ('todas', 'Todas'),
    ('aula', 'Aulas'),
    ('feriado', 'Feriados'),
    ('reuniao', 'Reuniões'),
    ('prazo', 'Prazos'),
    ('aviso', 'Avisos'),
    ('sistema', 'Sistema'),
  ];

  @override
  void initState() {
    super.initState();
    context.read<NotificationsCubit>().loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return DudaScaffold(
      appBar: const DudaAppBar(title: 'Notificações'),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          return switch (state.status) {
            NotificationsStatus.initial ||
            NotificationsStatus.loading =>
              const DudaLoading.skeleton(itemCount: 4),
            NotificationsStatus.failure => DudaErrorState(
                message: state.errorMessage ?? 'Erro ao carregar notificações',
                onRetry: () =>
                    context.read<NotificationsCubit>().loadNotifications(),
              ),
            NotificationsStatus.success => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Row(
                      children: _filters.map((filter) {
                        return Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.sm),
                          child: DudaChip(
                            label: filter.$2,
                            isSelected: state.selectedFilter == filter.$1,
                            onTap: () => context
                                .read<NotificationsCubit>()
                                .setFilter(filter.$1),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: state.filteredNotifications.isEmpty
                        ? const DudaEmptyState(
                            message: 'Nenhuma notificação nesta categoria.',
                            icon: Icons.notifications_off_outlined,
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                            ),
                            itemCount: state.filteredNotifications.length,
                            itemBuilder: (context, index) {
                              final notification =
                                  state.filteredNotifications[index];
                              return NotificationCard(
                                title: notification.title,
                                body: notification.body,
                                category: notification.category,
                                date: DateFormat('dd/MM HH:mm')
                                    .format(notification.date),
                                isRead: notification.isRead,
                                onTap: () => DudaScaffold.showSnackBar(
                                  context,
                                  notification.body,
                                ),
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
