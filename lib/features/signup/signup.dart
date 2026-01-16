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
    final signupState = ref.watch(signupControllerProvider);

    ref.listen<SignupState>(signupControllerProvider, (prev, next) {
      if (next.status == SignupStatus.success) {
        context.go('/home'); // navigate on successful signup
      } else if (next.status == SignupStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage ?? 'Signup failed')),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ScrollbarTheme(
        data: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(Colors.teal),
        ),
        child: Scrollbar(
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
                      color: Theme.of(context).colorScheme.onSurface,
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
                  if (signupState.status == SignupStatus.loading)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  if (signupState.status == SignupStatus.error)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Signup Error: ${signupState.errorMessage}',
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
      ),
    );
  }
}
