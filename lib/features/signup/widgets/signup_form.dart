import 'package:flutter/material.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:northpoint_church_app/features/signup/signup_controller.dart';
import "dart:io";
import 'package:northpoint_church_app/core/config/auth_enum.dart';
import 'package:northpoint_church_app/core/services/password_validator.dart';


class SignUpForm extends ConsumerWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final void Function() onSubmit;
  final supabaseService = GetIt.instance<SupabaseProvider>();
  final _formKey = GlobalKey<FormState>();

  SignUpForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signupControllerProvider);
    final signupController = ref.read(signupControllerProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.1),
                  foregroundImage: signupState.pickedImage != null
                      ? FileImage(File(signupState.pickedImage!.path))
                      : (signupState.avatarUrl != null
                            ? NetworkImage(
                                '${signupState.avatarUrl}?t=${DateTime.now().millisecondsSinceEpoch}',
                              )
                            : null),

                  child: signupState.avatarUrl == null
                      ? Icon(
                          Icons.person,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                ),
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: IconButton(
                    onPressed: () {
                      signupController.pickAvatar();
                    },
                    icon: const Icon(Icons.add_a_photo),
                  ),
                ),
                // Debug overlay - remove this after testing
                if (signupState.avatarUrl != null)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      color: Colors.black54,
                      child: Text(
                        'Image loaded',
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Pick a profile picture!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            Material(
              elevation: 4,
              shadowColor: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10.0),
              child: TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            Material(
              elevation: 4,
              shadowColor: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10.0),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!value.contains('@')) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            Material(
              elevation: 4,
              shadowColor: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }

                  final result = validatePassword(value);

                  if (result != AuthenticationResponses.success) {
                    return signupController.mapPasswordError(result);
                  }

                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            Material(
              elevation: 4,
              shadowColor: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10.0),
              child: TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != confirmPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    onSubmit(); // only runs if ALL fields are valid
                  }
                },
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
      ),
    );
  }
}
