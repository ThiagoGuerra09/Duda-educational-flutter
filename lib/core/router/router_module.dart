import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/router/app_router.dart';
import 'package:duda_educational_flutter/core/services/session_service.dart';

@module
abstract class RouterModule {
  @lazySingleton
  AppRouter appRouter(SessionService sessionService) =>
      AppRouter(sessionService);

  @lazySingleton
  GoRouter goRouter(AppRouter appRouter) => appRouter.router;
}
