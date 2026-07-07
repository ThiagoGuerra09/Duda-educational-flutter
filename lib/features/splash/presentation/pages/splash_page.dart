import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:duda_educational_flutter/core/router/routes.dart';
import 'package:duda_educational_flutter/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:duda_educational_flutter/features/splash/presentation/cubit/splash_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_loading.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_scaffold.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, this.onAuthenticated, this.onUnauthenticated});

  final VoidCallback? onAuthenticated;
  final VoidCallback? onUnauthenticated;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.authenticated) {
          widget.onAuthenticated?.call();
          context.go(AppRoutes.home);
        } else if (state.status == SplashStatus.unauthenticated) {
          widget.onUnauthenticated?.call();
          context.go(AppRoutes.login);
        }
      },
      child: DudaScaffold(
        backgroundColor: AppColors.primary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/star-logo.svg',
              height: 120,
              colorFilter: const ColorFilter.mode(
                AppColors.textOnPrimary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const DudaText.title(
              'Duda Educador',
              color: AppColors.textOnPrimary,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            const DudaLoading.circular(),
          ],
        ),
      ),
    );
  }
}
