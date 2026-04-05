import 'package:auth_shared/auth_shared.dart';
import 'package:auth_shared/widget/cards/user_card.dart';
import 'package:example/widget_preview_page.dart';
import 'package:flutter/material.dart';

class UserCardPreview extends StatefulWidget {
  const UserCardPreview({super.key});

  @override
  State<UserCardPreview> createState() => _UserCardPreviewState();
}

class _UserCardPreviewState extends State<UserCardPreview> {
  static const String imageUrl = "https://placehold.co/";
  final TextEditingController previewImage = TextEditingController();
  final TextEditingController imageWidth = TextEditingController();
  final TextEditingController imageHeight = TextEditingController();
  final TextEditingController imageBGColor = TextEditingController();
  final TextEditingController imageTextColor = TextEditingController();
  final List<String> extensions = ["png", "jpg", "jpeg", "webp"];
  String? selectedExt;
  final TextEditingController imageText = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    generateImage();

    firstNameController.text = "John";
    lastNameController.text = "Doe";
    usernameController.text = "johnnie_doe";
  }

  void generateImage() {
    previewImage.text = imageUrl;
    if (imageWidth.text.isNotEmpty) {
      previewImage.text += "${imageWidth.text}x";
    } else {
      previewImage.text += "600x";
    }
    if (imageHeight.text.isNotEmpty) {
      previewImage.text += imageHeight.text;
    } else {
      previewImage.text += "600";
    }
    if (imageBGColor.text.isNotEmpty) {
      previewImage.text += "/${imageBGColor.text}";
    } else {
      previewImage.text += "/000000";
    }
    if (imageTextColor.text.isNotEmpty) {
      previewImage.text += "/${imageTextColor.text}";
    } else {
      previewImage.text += "/FFFFFF";
    }
    if (selectedExt != null) {
      previewImage.text += ".$selectedExt";
    } else {
      previewImage.text += ".${extensions.first}";
    }
    if (imageText.text.isNotEmpty) {
      previewImage.text += "?text=${imageText.text}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WidgetPreviewPage(
      title: "User Card Preview",
      preview: UserCard(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        imageUrl: previewImage.text,
        title: usernameController.text,
        onTap: () => CustomDialogs.showActionDialog(
          context: context,
          title: "Success",
          text: "Are you sure you wanna do it?",
          confirmText: "Yes",
          onConfirm: () => CustomSnackbar.show(
            context: context,
            message: "You have done it successfully",
            snackbarType: SnackbarType.success,
          ),
        ),
      ),
      controls: [
        Container(
          padding: EdgeInsetsGeometry.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "IMAGE CONTROLS",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                "Image Dimension",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: imageWidth,
                      onChanged: (value) => setState(() {
                        imageWidth.text = value;
                        generateImage();
                      }),
                      decoration: InputDecoration(label: Text("Image Width")),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: imageHeight,
                      onChanged: (value) => setState(() {
                        imageHeight.text = value;
                        generateImage();
                      }),
                      decoration: InputDecoration(label: Text("Image Height")),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text("Image Colour",
                style: Theme.of(context).textTheme.titleSmall,),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: imageBGColor,
                      onChanged: (value) => setState(() {
                        imageBGColor.text = value;
                        generateImage();
                      }),
                      decoration: InputDecoration(
                        hintText: "000000",
                        label: Text("Background Color Hex"),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: imageTextColor,
                      onChanged: (value) => setState(() {
                        imageTextColor.text = value;
                        generateImage();
                      }),
                      decoration: InputDecoration(
                        hintText: "FFFFFF",
                        label: Text("Text Color Hex"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              DropdownButtonFormField<String?>(
                initialValue: extensions.first,
                decoration: const InputDecoration(labelText: "extensions"),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedExt = newValue ?? extensions.first;
                        generateImage();
                  });
                },
                items: extensions.map((entry) {
                  return DropdownMenuItem<String?>(
                    value: entry,
                    child: Text(entry),
                  );
                }).toList(),
              ),
              SizedBox(height: 6),
              Text("Image Text"),
              TextField(
                controller: imageText,
                onChanged: (value) => setState(() {
                  imageText.text = value;
                        generateImage();
                }),
                decoration: InputDecoration(hintText: "J D"),
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        TextField(
          controller: firstNameController,
          onChanged: (value) => setState(() {
            firstNameController.text = value;
          }),
          decoration: InputDecoration(label: Text("First Name")),
        ),
        SizedBox(height: 6),
        TextField(
          controller: lastNameController,
          onChanged: (value) => setState(() {
            lastNameController.text = value;
          }),
          decoration: InputDecoration(label: Text("Last Name")),
        ),
        SizedBox(height: 6),
        TextField(
          controller: usernameController,
          onChanged: (value) => setState(() {
            usernameController.text = value;
          }),
          decoration: InputDecoration(label: Text("Username")),
        ),
      ],
    );
  }
}
