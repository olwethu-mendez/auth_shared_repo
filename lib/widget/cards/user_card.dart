import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.firstName,
    required this.lastName,
    this.title,
    this.imageUrl,
    this.onTap,
    this.trailing
  });
  final String firstName;
  final String lastName;
  final String? title;
  final String? imageUrl;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
            leading: CircleAvatar(
              foregroundImage: imageUrl != null
                  ? CachedNetworkImageProvider(imageUrl!)
                  : null,
              child: imageUrl == null
                  ? Icon(Icons.account_circle)
                  : null,
            ),
            title: Text("$firstName $lastName"),
            subtitle: Text(title!),
            onTap: onTap,
            trailing: trailing,
          );
  }
}
