import 'package:example/previews/custom_dialogs_preview.dart';
import 'package:example/previews/custom_icon_button_preview.dart';
import 'package:example/previews/custom_snackbar_preview.dart';
import 'package:example/previews/modal_bottom_sheet_preview.dart';
import 'package:example/previews/password_input_preview.dart';
import 'package:example/previews/phone_number_input_preview.dart';
import 'package:example/widgets/sidelined_header.dart';
import 'package:flutter/material.dart';

class WidgetGallery extends StatelessWidget {
  const WidgetGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      SidelinedHeader(title: "Inputs"),
      _GalleryItem("Password Input", PasswordInputPreview()),
      _GalleryItem("Phone Number Input", PhoneNumberInputPreview()),
      SidelinedHeader(title: "Buttons"),
      _GalleryItem("Icon Button", CustomIconButtonPreview()),
      SidelinedHeader(title: "Popups"),
      _GalleryItem("Alert Dialog", CustomDialogsPreview()),
      _GalleryItem("Modal Bottom Sheet", ModalBottomSheetPreview()),
      _GalleryItem("Snack Bar", CustomSnackarPreview()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Auth Shared Widgets Library"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          final item = items[index];

          return item is _GalleryItem ?
           ListTile(
            title: Text(item.title),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => item.widget));
            },
          ): item is SidelinedHeader ?
          item : null;
        }),
    );
  }
}

class _GalleryItem {
  final String title;
  final Widget widget;

  _GalleryItem(this.title, this.widget);
}