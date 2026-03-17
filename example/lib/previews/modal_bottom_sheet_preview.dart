import 'package:auth_shared/widget/cards/user_card.dart';
import 'package:auth_shared/widget/library.dart';
import 'package:example/widget_preview_page.dart';
import 'package:example/widgets/inline_text_button_control.dart';
import 'package:flutter/material.dart';

class ModalBottomSheetPreview extends StatefulWidget {
  const ModalBottomSheetPreview({super.key});

  @override
  State<ModalBottomSheetPreview> createState() =>
      _ModalBottomSheetPreviewState();
}

class _ModalBottomSheetPreviewState extends State<ModalBottomSheetPreview> {
  String modalTitle = "Modal Bottom Sheet";
  List<Widget> sheetContent = [
    UserCard(firstName: "John", lastName: "Doe", title: "Software Developer"),
    Divider(),
  ];

  final Map<String, IconData> icons = {
    "Home": Icons.home,
    "Phone": Icons.phone,
    "Person": Icons.person,
    "Email": Icons.email,
    "Lock": Icons.lock,
    "Fingerprint": Icons.fingerprint,
    "Settings": Icons.settings,
  };
  IconData? iconController;
  TextEditingController modalContentItem = TextEditingController();
  bool hasActions = false;

  @override
  Widget build(BuildContext context) {
    return WidgetPreviewPage(
      title: modalTitle,
      preview: ElevatedButton(
        onPressed: () => CustomModalBottomSheet.show(
          context: context,
          title: modalTitle,
          child: Column(children: sheetContent),
          actions: hasActions
              ? <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Action Confimed'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context, true);
                    },
                    child: const Text("Delete"),
                  ),
                ]
              : null,
        ),
        child: Text("Show Modal"),
      ),
      controls: [
        Row(
          children: [
            SizedBox(
              width: 75,
              child: DropdownButtonFormField<IconData>(
                initialValue: iconController,
                decoration: const InputDecoration(labelText: "Icons"),
                onChanged: (IconData? newValue) {
                  setState(() {
                    iconController = newValue ?? Icons.fingerprint;
                  });
                },
                items: icons.entries.map((entry) {
                  return DropdownMenuItem<IconData>(
                    value: entry.value,
                    child: Row(
                      children: [
                        Icon(entry.value),
                        // const SizedBox(width: 10),
                        // Text(entry.key),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: InlineTextButtonControl(
                textEditingController: modalContentItem,
                onPressed: () {
                  sheetContent.add(
                    ListTile(
                      leading: Icon(iconController),
                      title: Text(modalContentItem.text),
                    ),
                  );
                  setState(() {
                    modalContentItem.clear();
                    iconController = null;
                  });
                },
                textLabel: "Add to Modal",
                buttonLabel: Icon(Icons.add),
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            // First RadioListTile
            DynamicRadioGroup<bool>(
              selectedValue: false,
              items: const [true, false],
              labelBuilder: (item) => item ? "Has Actions" : "Has no Actions",
              onChanged: (value) => setState(() => hasActions = value!),
            )
          ],
        ),
      ],
    );
  }
}
