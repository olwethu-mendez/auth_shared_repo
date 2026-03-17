import 'package:auth_shared/widget/library.dart';
import 'package:example/widget_preview_page.dart';
import 'package:flutter/material.dart';

class CustomIconButtonPreview extends StatefulWidget {
  const CustomIconButtonPreview({super.key});

  @override
  State<CustomIconButtonPreview> createState() =>
      _CustomIconButtonPreviewState();
}

class _CustomIconButtonPreviewState extends State<CustomIconButtonPreview> {
  IconData icon = Icons.fingerprint;
  final Map<String, IconData> icons = {
    "Home": Icons.home,
    "Phone": Icons.phone,
    "Person": Icons.person,
    "Email": Icons.email,
    "Lock": Icons.lock,
    "Fingerprint": Icons.fingerprint,
    "Settings": Icons.settings,
  };
  String label = "Label";
  bool submitting = false;
  @override
  Widget build(BuildContext context) {
    return WidgetPreviewPage(
      title: "Custom Button Preview",
      preview: CustomIconButton(
        isSubmitting: submitting,
        icon: Icon(icon),
        label: label,
        onPressed: () async {
          setState(() {
            submitting = true;
          });
          await showDialog(
            context: context,
            builder: (_innerContext) => AlertDialog(
              title: Text("Perform Action"),
              content: Text("You just Performed an action"),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.pop(_innerContext);
                    setState(() {
                      submitting = false;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      controls: [
        TextField(
          decoration: const InputDecoration(labelText: "Button Label"),
          onChanged: (value) {
            setState(() => label = value);
          },
        ),
        DropdownButtonFormField<IconData>(
          value: icon,
          decoration: const InputDecoration(labelText: "Select Icon"),
          onChanged: (IconData? newValue) {
            setState(() {
              icon = newValue ?? Icons.fingerprint;
            });
          },
          items: icons.entries.map((entry) {
            return DropdownMenuItem<IconData>(
              value: entry.value,
              child: Row(
                children: [
                  Icon(entry.value),
                  const SizedBox(width: 10),
                  Text(entry.key),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
