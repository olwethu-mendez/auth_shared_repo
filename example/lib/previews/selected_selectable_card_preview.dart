import 'package:auth_shared/auth_shared.dart'; // Adjust based on your actual package name
import 'package:auth_shared/widget/cards/selectable_item_card.dart';
import 'package:auth_shared/widget/cards/selected_item_card.dart';
import 'package:example/widget_preview_page.dart';
import 'package:flutter/material.dart';

class SelectableItemPreview extends StatefulWidget {
  const SelectableItemPreview({super.key});

  @override
  State<SelectableItemPreview> createState() => _SelectableItemPreviewState();
}

class _SelectableItemPreviewState extends State<SelectableItemPreview> {
  // Image Generation State
  static const String baseUrl = "https://placehold.co/";
  final TextEditingController imageWidth = TextEditingController(text: "100");
  final TextEditingController imageHeight = TextEditingController(text: "100");
  final TextEditingController imageBGColor = TextEditingController(text: "6200EE");
  final TextEditingController imageTextColor = TextEditingController(text: "FFFFFF");
  final TextEditingController imageText = TextEditingController(text: "Logo");
  String previewImageUrl = "";

  // Card Content State
  final TextEditingController titleController = TextEditingController(text: "Design System Project");
  final TextEditingController subtitleController = TextEditingController(text: "Managed by Creative Team");
  bool isSelected = false;
  
  // Selection List for Summary Preview
  final List<String> selectedItems = ["Mobile App", "Web Dashboard"];

  @override
  void initState() {
    super.initState();
    _generateUrl();
  }

  void _generateUrl() {
    setState(() {
      previewImageUrl = "$baseUrl${imageWidth.text}x${imageHeight.text}/"
          "${imageBGColor.text.isEmpty ? "000000" : imageBGColor.text}/"
          "${imageTextColor.text.isEmpty ? "FFFFFF" : imageTextColor.text}"
          ".png?text=${imageText.text.replaceAll(" ", "+")}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return WidgetPreviewPage(
      title: "Selectable Item Preview",
      preview: Column(
        children: [
          // 1. The Selectable Card
          SelectableItemCard(
            title: titleController.text,
            subtitle: subtitleController.text,
            imageUrl: previewImageUrl,
            isSelected: isSelected,
            onTap: () => setState(() => isSelected = !isSelected),
            bottomActionWidget: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: const Text("VIEW DETAILS")),
                ElevatedButton(onPressed: () {}, child: const Text("MANAGE")),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const Text("Selection Summary (Horizontal Scroll)"),
          const SizedBox(height: 8),
          // 2. The Summary Chips
          SelectedItemsSummary<String>(
            items: selectedItems,
            labelBuilder: (item) => item,
            onDeleted: (item) {
              setState(() => selectedItems.remove(item));
            },
          ),
        ],
      ),
      controls: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("IMAGE CONTROLS", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: imageWidth,
                      onChanged: (_) => _generateUrl(),
                      decoration: const InputDecoration(labelText: "Width"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: imageHeight,
                      onChanged: (_) => _generateUrl(),
                      decoration: const InputDecoration(labelText: "Height"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: imageBGColor,
                      onChanged: (_) => _generateUrl(),
                      decoration: const InputDecoration(labelText: "BG Hex", hintText: "6200EE"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: imageTextColor,
                      onChanged: (_) => _generateUrl(),
                      decoration: const InputDecoration(labelText: "Text Hex", hintText: "FFFFFF"),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: imageText,
                onChanged: (_) => _generateUrl(),
                decoration: const InputDecoration(labelText: "Placeholder Text"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text("CARD CONTENT", style: Theme.of(context).textTheme.titleMedium),
        TextField(
          controller: titleController,
          onChanged: (v) => setState(() {}),
          decoration: const InputDecoration(labelText: "Title"),
        ),
        TextField(
          controller: subtitleController,
          onChanged: (v) => setState(() {}),
          decoration: const InputDecoration(labelText: "Subtitle"),
        ),
        SwitchListTile(
          title: const Text("Force Selected State"),
          value: isSelected,
          onChanged: (v) => setState(() => isSelected = v),
        ),
        const SizedBox(height: 16),
        Text("SUMMARY CONTROLS", style: Theme.of(context).textTheme.titleMedium),
        ElevatedButton.icon(
          onPressed: () {
            setState(() => selectedItems.add("New Item ${selectedItems.length + 1}"));
          },
          icon: const Icon(Icons.add),
          label: const Text("Add Item to Summary"),
        ),
      ],
    );
  }
}