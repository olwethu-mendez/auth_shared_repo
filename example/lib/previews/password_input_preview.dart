import 'package:auth_shared/widget/library.dart';
import 'package:example/widget_preview_page.dart';
import 'package:flutter/material.dart';

class PasswordInputPreview extends StatefulWidget {
  const PasswordInputPreview({super.key});

  @override
  State<PasswordInputPreview> createState() => _PasswordInputPreviewState();
}

class _PasswordInputPreviewState extends State<PasswordInputPreview> {
  final controller = TextEditingController();

  String label = "Password";

  @override
  Widget build(BuildContext context) {
    return WidgetPreviewPage(
      title: "Password Input Preview",
      preview: PasswordInput(passwordController: controller, labelText: label),
      controls: [
        TextField(
          decoration: const InputDecoration(labelText: "Password Label"),
          onChanged: (value) {
            setState(() => label = value);
          },
        ),
      ],
    );
  }
}
