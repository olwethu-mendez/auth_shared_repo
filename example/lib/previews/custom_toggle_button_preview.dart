import 'package:auth_shared/widget/library.dart';
import 'package:example/widget_preview_page.dart';
import 'package:flutter/material.dart';

class CustomToggleButtonPreview extends StatefulWidget {
  const CustomToggleButtonPreview({super.key});

  @override
  State<CustomToggleButtonPreview> createState() =>
      _CustomToggleButtonPreviewState();
}

class _CustomToggleButtonPreviewState extends State<CustomToggleButtonPreview> {
  final Map<String, IconData?> icons = {
    "Select Icon": null,
    "Home": Icons.home,
    "Phone": Icons.phone,
    "Person": Icons.person,
    "Email": Icons.email,
    "Lock": Icons.lock,
    "Fingerprint": Icons.fingerprint,
    "Settings": Icons.settings,
  };
  final List<Widget> buttonLabels = [];
  final List<bool> isSelected = [];
  final TextEditingController textLabel = TextEditingController();

  bool isWrapped = false;

  void _addItem(Widget widget) {
    setState(() {
      buttonLabels.add(widget);
      isSelected.add(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WidgetPreviewPage(
      title: "Custom Toggle Button Preview",
      preview: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (buttonLabels.isEmpty)
            const Text("Add labels below to see the toggle button")
          else
            CustomToggleButton(
              isSelected: isSelected,
              buttonLabels: buttonLabels,
              onPressed: (index) {
                setState(() {
                  // Toggle logic: allows only one selected (Radio style)
                  // or multiple (Checkbox style). This example does radio style:
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] = i == index;
                  }
                });
              },
              isWrapped: isWrapped,
            ),
          const SizedBox(height: 20),
          if (buttonLabels.isNotEmpty)
            TextButton.icon(
              onPressed: () => setState(() {
                buttonLabels.clear();
                isSelected.clear();
              }),
              icon: const Icon(Icons.delete_outline),
              label: const Text("Clear All"),
            ),
        ],
      ),
      controls: [
        TextField(
          controller: textLabel,
          decoration: InputDecoration(
            labelText: "Add Text Label",
            suffixIcon: IconButton(
              onPressed: () {
                if (textLabel.text.isNotEmpty) {
                  _addItem(Text(textLabel.text));
                }
              },
              icon: Icon(Icons.add),
            ),
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<IconData>(
          decoration: const InputDecoration(labelText: "Add Icon Label"),
          items: icons.entries.where((e) => e.value != null).map((entry) {
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
          onChanged: (IconData? newValue) {
            if (newValue != null) {
              _addItem(Icon(newValue));
            }
          },
        ),
        SizedBox(height: 16),
                DynamicRadioGroup<bool>(
          title: "Wrapped",
          selectedValue: isWrapped,
          items: const [true, false],
          labelBuilder: (item) => item ? "True" : "False",
          onChanged: (value) => setState(() => isWrapped = value ?? false),
          wrapped: true,
        ),
      ],
    );
  }
}
