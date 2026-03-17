import 'package:auth_shared/widget/library.dart';
import 'package:example/widget_preview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomDialogsPreview extends StatefulWidget {
  const CustomDialogsPreview({super.key});

  @override
  State<CustomDialogsPreview> createState() => _CustomDialogsPreviewState();
}

class _CustomDialogsPreviewState extends State<CustomDialogsPreview> {
  //PREVIEW VARIABLES
  String dialogTitle = "Alert Dialog";
  String dialogText = "Dialog Text Content";
  String confirmText = "Confirm";
  void onConfirm(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Action Confimed'), backgroundColor: Colors.green),
    );
  }

  String? cancelText;
  void onCancel(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Action Cancelled'), backgroundColor: Colors.red),
    );
  }

  bool? isDestructive;
  Color? confirmColor;

  //CONTROL VARIABLES

  @override
  Widget build(BuildContext context) {
    return WidgetPreviewPage(
      title: "Alert Dialog Preview",
      preview: ElevatedButton(
        onPressed: () => CustomDialogs.showActionDialog(
          context: context,
          title: dialogTitle,
          text: dialogText,
          confirmText: confirmText,
          onConfirm: () => onConfirm(context),
          cancelText: cancelText,
          onCancel: cancelText != null ? () => onCancel(context) : null,
          isDestructive: isDestructive ?? false,
          confirmColor: confirmColor,
        ),
        child: Text("Show Alert"),
      ),
      controls: [
        TextField(
          decoration: InputDecoration(labelText: "Alert Title Value"),
          onChanged: (value) => setState(() => dialogTitle = value),
        ),
        TextField(
          decoration: InputDecoration(labelText: "Alert Text Value"),
          onChanged: (value) => setState(() => dialogText = value),
        ),
        TextField(
          decoration: InputDecoration(labelText: "Confirm Text Value"),
          onChanged: (value) => setState(() => confirmText = value),
        ),
        TextField(
          decoration: InputDecoration(labelText: "Cancel Text Value"),
          onChanged: (value) => value.isNotEmpty
              ? setState(() => cancelText = value)
              : setState(() => cancelText = null),
        ),
        ColorPicker(
          pickerColor: confirmColor ?? Colors.blue,
          onColorChanged: (color) => confirmColor = color,
        ),
        DynamicRadioGroup<bool>(
          selectedValue: isDestructive ?? false,
          items: const [true, false],
          labelBuilder: (item) => item ? "Destructive" : "Not Destructive",
          onChanged: (value) => setState(() => isDestructive = value),
        ),
      ],
    );
  }
}
