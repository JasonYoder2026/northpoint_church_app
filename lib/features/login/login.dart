import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/colors.dart';
import 'login_controller.dart';
import 'widgets/login_form.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    ref
        .read(loginControllerProvider.notifier)
        .login(emailController.text.trim(), passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(loginControllerProvider);

    ref.listen<LoginStatus>(loginControllerProvider, (prev, next) {
      if (next == LoginStatus.success) {
        context.go('/home'); // navigate on successful login
      } else if (next == LoginStatus.error) {
        final error = ref.read(loginControllerProvider.notifier).errorMessage;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error ?? 'Login failed')));
      }
    });

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/logo.png', height: 125),
              const SizedBox(height: 32),
              Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              LoginForm(
                emailController: emailController,
                passwordController: passwordController,
                onSubmit: _submit,
              ),
              if (status == LoginStatus.loading)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              if (status == LoginStatus.error)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Invalid username or password',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 20,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
