import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final void Function() onSubmit;

  const SignUpForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            elevation: 4,
            shadowColor: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10.0),
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
          ),
          Material(
            elevation: 4,
            shadowColor: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10.0),
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Material(
            elevation: 4,
            shadowColor: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10.0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Material(
            elevation: 4,
            shadowColor: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10.0),
            child: TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Sign Up', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
