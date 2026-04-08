import 'package:auth_shared/widget/cards/user_card.dart';
import 'package:auth_shared/widget/library.dart';
import 'package:example/widget_preview_page.dart';
import 'package:flutter/material.dart';

class GreyedOutPreview extends StatefulWidget {
  const GreyedOutPreview({super.key});

  @override
  State<GreyedOutPreview> createState() => _GreyedOutPreviewState();
}

class _GreyedOutPreviewState extends State<GreyedOutPreview> {
  // Use a string to track which widget to display
  String selectedWidget = 'textbox';
  bool isDisabled = true;

  /// Helper to build the child based on the selection.
  /// This ensures the UserCard always has the required fields to prevent null crashes.
  Widget _buildPreviewChild() {
    switch (selectedWidget) {
      case 'button':
        return ElevatedButton(
          onPressed: () => CustomSnackbar.show(
            context: context,
            message: "Button clicked!",
            snackbarType: SnackbarType.info,
          ),
          child: const Text("Elevated Button"),
        );
      case 'checkbox':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Checkbox: "),
            Checkbox.adaptive(
              value: true,
              onChanged: (val) {},
            ),
          ],
        );
      case 'usercard':
        return UserCard(
          firstName: "John",
          lastName: "Doe",
          title: "Senior Developer",
          imageUrl: null,
          onTap: () => CustomSnackbar.show(
            context: context,
            message: "User Card tapped!",
            snackbarType: SnackbarType.info,
          ),
        );
      case 'textbox':
      default:
        return const TextField(
          decoration: InputDecoration(
            labelText: "Sample Input",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.edit),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WidgetPreviewPage(
      title: "GreyedOut Utility Preview",
      preview: GreyedOut(
        isDisabled: isDisabled,
        child: _buildPreviewChild(),
      ),
      controls: [
        // Selection group for the child widget
        DynamicRadioGroup<String>(
          title: "Child Widget Type",
          selectedValue: selectedWidget,
          items: const ['textbox', 'button', 'checkbox', 'usercard'],
          labelBuilder: (item) {
            switch (item) {
              case 'textbox': return "Text Field";
              case 'button': return "Button";
              case 'checkbox': return "Checkbox";
              case 'usercard': return "User Card";
              default: return item;
            }
          },
          onChanged: (value) => setState(() => selectedWidget = value!),
          wrapped: true,
        ),
        const SizedBox(height: 24),
        // Toggle for the GreyedOut state
        DynamicRadioGroup<bool>(
          title: "Is Disabled (Greyed Out)",
          selectedValue: isDisabled,
          items: const [true, false],
          labelBuilder: (item) => item ? "TRUE (Greyed)" : "FALSE (Normal)",
          onChanged: (value) => setState(() => isDisabled = value!),
          wrapped: false,
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Note: The GreyedOut widget applies an opacity and ignores pointer events when isDisabled is true.",
            style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }
}