import 'package:auth_shared/widget/library.dart';
import 'package:example/widget_preview_page.dart';
import 'package:example/widgets/inline_text_button_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomSnackarPreview extends StatefulWidget {
  const CustomSnackarPreview({super.key});

  @override
  State<CustomSnackarPreview> createState() => _CustomSnackarPreviewState();
}

enum SecTypes { microSec, milisec, sec }

class _CustomSnackarPreviewState extends State<CustomSnackarPreview> {
  //PREVIEW VARIABLES
  String message = "Action has been taken and this is the message.";
  
  SnackbarType? snackBarType;
  Color? textColor;
  bool? closable;
  bool? usesIcon;

  SecTypes? durType;
  TextEditingController controller = TextEditingController();
  int? durationValue;

  //CONTROL VARIABLES

  @override
  Widget build(BuildContext context) {
    return WidgetPreviewPage(
      title: "Snackbar Preview",
      preview: ElevatedButton(
        onPressed: () => CustomSnackbar.show(
          context: context,
          message: message,
          closable: closable,
          usesIcon: usesIcon,
          microSecDuration: durType == SecTypes.microSec ? durationValue : null,
          milisecDuration: durType == SecTypes.milisec ? durationValue : null,
          secDuration: durType == SecTypes.sec ? durationValue : null,
          snackbarType: snackBarType ?? SnackbarType.info,
          textColor: textColor,
        ),
        child: Text("Show Snackbar"),
      ),
      controls: [
        TextField(
          decoration: InputDecoration(labelText: "Message Value"),
          onChanged: (value) => setState(() => message = value),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 132,
              child: DropdownButtonFormField<SecTypes>(
                initialValue: durType,
                decoration: const InputDecoration(labelText: "Duration"),
                items: [
                  DropdownMenuItem(
                    value: SecTypes.microSec,
                    child: Text("Microseconds"),
                  ),
                  DropdownMenuItem(
                    value: SecTypes.milisec,
                    child: Text("Milliseconds"),
                  ),
                  DropdownMenuItem(value: SecTypes.sec, child: Text("Seconds")),
                ],
                onChanged: (val) => setState(() => durType = val),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: InlineTextButtonControl(
                textEditingController: controller,
                onPressed: () => setState(
                  () => durationValue = int.tryParse(controller.text),
                ),
                textLabel: durType == SecTypes.microSec
                    ? "Microseconds"
                    : durType == SecTypes.milisec
                    ? "Miliseconds"
                    : durType == SecTypes.sec
                    ? "Seconds"
                    : "Microseconds",
                buttonLabel: Icon(Icons.add),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<SnackbarType>(
          initialValue: snackBarType,
          decoration: const InputDecoration(labelText: "Select SnackBar Type"),
          onChanged: (newValue) {
            setState(() {
              snackBarType = newValue;
            });
          },
          items: SnackbarType.values.map((entry) {
            return DropdownMenuItem<SnackbarType>(
              value: entry,
              child: Row(
                children: [
                  Text(entry.name.toUpperCase()),
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 8),
        DynamicRadioGroup<bool>(
          title: "Widget is closable",
          selectedValue: closable ?? false,
          items: const [true, false],
          labelBuilder: (item) => item ? "Closable" : "Not Closable",
          onChanged: (value) => setState(() => closable = value!),
          wrapped: false,
        ),
        SizedBox(height: 8),
        DynamicRadioGroup<bool>(
          title: "Include Icons",
          selectedValue: usesIcon ?? false,
          items: const [true, false],
          labelBuilder: (item) => item ? "Include Icon" : "Exclude Icon",
          onChanged: (value) => setState(() => usesIcon = value!),
          wrapped: true,
        ),
        SizedBox(height: 8),
        ListTile(
          title: const Text("Text Color"),
          leading: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: textColor ?? Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Pick a color'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: textColor ?? Colors.blue,
                    onColorChanged: (color) =>
                        setState(() => textColor = color),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
