import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? avatarUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: avatarUrl != null
              ? NetworkImage(avatarUrl!)
              : const AssetImage('assets/images/logo.png') as ImageProvider,
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headlineLarge?.color,
          ),
        ),
        const SizedBox(height: 4),
        Text(email, style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.headlineLarge?.color,)),
      ],
    );
  }
}
