import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';

class DudaApp extends StatelessWidget {
  const DudaApp({required this.router, super.key});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Duda Educador',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.surface,
        ),
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Inter',
      ),
      routerConfig: router,
    );
  }
}
