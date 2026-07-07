import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:duda_educational_flutter/core/router/routes.dart';
import 'package:duda_educational_flutter/core/services/session_service.dart';
import 'package:duda_educational_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:duda_educational_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:duda_educational_flutter/features/chat/presentation/cubit/chat_list_cubit.dart';
import 'package:duda_educational_flutter/features/chat/presentation/cubit/chat_messages_cubit.dart';
import 'package:duda_educational_flutter/features/chat/presentation/pages/chat_list_page.dart';
import 'package:duda_educational_flutter/features/chat/presentation/pages/chat_messages_page.dart';
import 'package:duda_educational_flutter/features/classes/presentation/cubit/class_detail_cubit.dart';
import 'package:duda_educational_flutter/features/classes/presentation/cubit/classes_cubit.dart';
import 'package:duda_educational_flutter/features/classes/presentation/pages/class_detail_page.dart';
import 'package:duda_educational_flutter/features/classes/presentation/pages/classes_page.dart';
import 'package:duda_educational_flutter/features/home/presentation/cubit/home_cubit.dart';
import 'package:duda_educational_flutter/features/home/presentation/pages/home_page.dart';
import 'package:duda_educational_flutter/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:duda_educational_flutter/features/notifications/presentation/pages/notifications_page.dart';
import 'package:duda_educational_flutter/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:duda_educational_flutter/features/profile/presentation/pages/profile_page.dart';
import 'package:duda_educational_flutter/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:duda_educational_flutter/features/schedule/presentation/pages/schedule_page.dart';
import 'package:duda_educational_flutter/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:duda_educational_flutter/features/splash/presentation/pages/splash_page.dart';
import 'package:duda_educational_flutter/injection.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_bottom_navigation.dart';

class MainShellPage extends StatelessWidget {
  const MainShellPage({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _items = [
    DudaBottomNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Início',
    ),
    DudaBottomNavItem(
      icon: Icons.menu_book_outlined,
      activeIcon: Icons.menu_book,
      label: 'Disciplinas',
    ),
    DudaBottomNavItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Perfil',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DudaBottomNavigation(
        currentIndex: navigationShell.currentIndex,
        onTap: navigationShell.goBranch,
        items: _items,
      ),
    );
  }
}

class AppRouter {
  AppRouter(this._sessionService);

  final SessionService _sessionService;

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) {
      final isLoggedIn = _sessionService.isLoggedIn;
      final location = state.matchedLocation;
      final isSplash = location == AppRoutes.splash;
      final isLogin = location == AppRoutes.login;

      if (isSplash) return null;
      if (!isLoggedIn && !isLogin) return AppRoutes.login;
      if (isLoggedIn && isLogin) return AppRoutes.home;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<SplashCubit>(),
          child: const SplashPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<AuthCubit>(),
          child: const LoginPage(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShellPage(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => BlocProvider(
                  create: (_) => getIt<HomeCubit>(),
                  child: const HomePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.classes,
                builder: (context, state) => BlocProvider(
                  create: (_) => getIt<ClassesCubit>(),
                  child: const ClassesPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => getIt<ProfileCubit>()),
                    BlocProvider(create: (_) => getIt<AuthCubit>()),
                  ],
                  child: const ProfilePage(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.schedule,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<ScheduleCubit>(),
          child: const SchedulePage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<NotificationsCubit>(),
          child: const NotificationsPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.chat,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<ChatListCubit>(),
          child: const ChatListPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.classDetail,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return BlocProvider(
            create: (_) => getIt<ClassDetailCubit>()..loadDetail(id),
            child: ClassDetailPage(classId: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.chatMessages,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final name = state.uri.queryParameters['name'] ?? 'Chat';
          return BlocProvider(
            create: (_) => getIt<ChatMessagesCubit>()..loadMessages(id),
            child: ChatMessagesPage(conversationId: id, participantName: name),
          );
        },
      ),
    ],
  );
}
