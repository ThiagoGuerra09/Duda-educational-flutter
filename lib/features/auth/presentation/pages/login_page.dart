import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:duda_educational_flutter/core/router/routes.dart';
import 'package:duda_educational_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:duda_educational_flutter/features/auth/presentation/cubit/auth_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_button.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_scaffold.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_textfield.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.go(AppRoutes.home);
        }
        if (state.status == AuthStatus.failure && state.errorMessage != null) {
          DudaScaffold.showSnackBar(context, state.errorMessage!);
        }
      },
      builder: (context, state) {
        final isLoading = state.status == AuthStatus.loading;

        return DudaScaffold(
          isLoading: isLoading,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.xxl),
                  Center(
                    child: SvgPicture.asset(
                      'assets/icons/star-logo.svg',
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const DudaText.headline(
                    'Duda Educador',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const DudaText.body(
                    'Entre com suas credenciais para continuar',
                    textAlign: TextAlign.center,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  DudaTextField(
                    label: 'E-mail',
                    hint: 'seu.email@cruzeiro.edu.br',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe seu e-mail';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  DudaTextField(
                    label: 'Senha',
                    hint: 'Digite sua senha',
                    controller: _passwordController,
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe sua senha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  DudaButton(
                    label: 'Entrar',
                    onPressed: isLoading ? null : _submit,
                    isLoading: isLoading,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
