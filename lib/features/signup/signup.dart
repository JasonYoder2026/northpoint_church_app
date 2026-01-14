import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/colors.dart';
import 'signup_controller.dart';
import 'widgets/signup_form.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    ref
        .read(signupControllerProvider.notifier)
        .signup(
          nameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(signupControllerProvider);

    ref.listen<SignupStatus>(signupControllerProvider, (prev, next) {
      if (next == SignupStatus.success) {
        context.go('/home'); // navigate on successful signup
      } else if (next == SignupStatus.error) {
        final error = ref.read(signupControllerProvider.notifier).errorMessage;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error ?? 'Signup failed')));
      }
    });

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: 80,
              ), // leave space for button
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 120),
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SignUpForm(
                    nameController: nameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    onSubmit: _submit,
                  ),
                  if (status == SignupStatus.loading)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  if (status == SignupStatus.error)
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
                  SizedBox(height: 150),
                ],
              ),
            ),
          ),

          // Back button is now visible on top
          Positioned(
            bottom: 0,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Theme.of(context).primaryColor,
              iconSize: 32,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
