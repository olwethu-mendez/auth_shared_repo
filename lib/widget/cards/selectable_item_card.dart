import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SelectableItemCard extends StatelessWidget {
  const SelectableItemCard({
    super.key,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.placeholderIcon = Icons.person,
    this.trailing,
    this.onTap,
    this.isSelected = false,
    this.selectedColor,
    this.bottomActionWidget, // Abstracted the ToggleButtons area
  });

  final String title;
  final String? subtitle;
  final String? imageUrl;
  final IconData placeholderIcon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isSelected;
  final Color? selectedColor;
  final Widget? bottomActionWidget;

  @override
  Widget build(BuildContext context) {
    final activeColor = selectedColor ?? Theme.of(context).primaryColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? activeColor.withOpacity(0.05) : Colors.transparent,
        border: Border.all(
          color: isSelected ? activeColor : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: CircleAvatar(
              foregroundImage: imageUrl != null && imageUrl!.isNotEmpty
                  ? CachedNetworkImageProvider(imageUrl!)
                  : null,
              child: Icon(placeholderIcon),
            ),
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: subtitle != null ? Text(subtitle!) : null,
            onTap: onTap,
            trailing: trailing ?? (isSelected 
                ? const Icon(Icons.check_circle, color: Colors.green) 
                : const Icon(Icons.add_circle_outline)),
          ),
          if (isSelected && bottomActionWidget != null)
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
              child: bottomActionWidget!,
            ),
        ],
      ),
    );
  }
}