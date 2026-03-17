import 'package:auth_shared/widget/library.dart';
import 'package:example/widget_preview_page.dart';
import 'package:example/widgets/inline_text_button_control.dart';
import 'package:example/widgets/stacked_text_button_control.dart';
import 'package:flutter/material.dart';

class PhoneNumberInputPreview extends StatefulWidget {
  const PhoneNumberInputPreview({super.key});

  @override
  State<PhoneNumberInputPreview> createState() =>
      _PhoneNumberInputPreviewState();
}

class _PhoneNumberInputPreviewState extends State<PhoneNumberInputPreview> {
  final countryCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final supportedController = TextEditingController();
  final localController = TextEditingController();

  List<String> supportedCodes = ['+1', '+27'];
  String localCode = "+27";

  @override
  Widget build(BuildContext context) {
    return WidgetPreviewPage(
      title: "Phone Number Input Preview",

      preview: PhoneNumberInput(
        supportedCodes: supportedCodes,
        phoneNumberController: phoneNumberController,
        countryCodeController: countryCodeController,
        localCode: localCode,
      ),

      controls: [
        StackedTextButtonControl(
          textLabel: "Local Code",
          buttonLabel: Text("Add Local Code"),
          textEditingController: localController,
          onPressed: () {
            setState(() {
              localCode = localController.text;
              localController.clear();
            });
          },
        ),

        InlineTextButtonControl(
          textEditingController: supportedController,
          onPressed: () {
            setState(() {
              supportedCodes.add(supportedController.text);
              supportedController.clear();
            });
          },
          textLabel: "Supported Code",
          buttonLabel: Icon(Icons.add),
        ),
      ],
    );
  }
}
