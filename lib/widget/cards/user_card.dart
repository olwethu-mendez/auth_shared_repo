import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.firstName,
    required this.lastName,
    this.title,
    this.imageUrl,
    this.onTap,
  });
  final String firstName;
  final String lastName;
  final String? title;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: imageUrl != null ? Image.network(imageUrl!) : Icon(Icons.person),
      ),
      title: Text("$firstName $lastName"), // User's name
      subtitle: title != null ? Text(title!) : null, // User's role/info
      trailing: onTap != null
          ? const Icon(Icons.arrow_forward_ios)
          : null, // Trailing icon
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
    );
  }
}
