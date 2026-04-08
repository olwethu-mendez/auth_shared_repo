part of '../library.dart';

class CustomToggleButton extends StatelessWidget {
  const CustomToggleButton({
    super.key,
    required this.isSelected,
    required this.buttonLabels,
    this.activeButtonColor,
    this.activeTextColor,
    required this.onPressed,
    this.isWrapped = false, // Added parameter
  });

  final List<bool> isSelected;
  final List<Widget> buttonLabels;
  final Function(int)? onPressed;
  final Color? activeButtonColor;
  final Color? activeTextColor;
  final bool isWrapped; // Control parameter

  @override
  Widget build(BuildContext context) {
    // 1. Wrapping Logic (Multi-line)
    if (isWrapped) {
      return Wrap(
        spacing: 8.0, // Horizontal space between buttons
        runSpacing: 8.0, // Vertical space between lines
        children: List.generate(buttonLabels.length, (index) {
          final bool selected = isSelected[index];
          return InkWell(
            onTap: () => onPressed?.call(index),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16),
              constraints: BoxConstraints(
                minHeight: 45,
                minWidth: 120,
                maxHeight: 45,
                maxWidth: 120,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? (activeButtonColor ?? Theme.of(context).colorScheme.primary)
                    : Colors.transparent,
                border: Border.all(
                  color: selected 
                      ? Colors.transparent 
                      : Theme.of(context).dividerColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: selected
                      ? (activeTextColor ?? Theme.of(context).colorScheme.surface)
                      : Theme.of(context).textTheme.bodyMedium?.color,
                ),
                child: buttonLabels[index],
              ),
            ),
          );
        }),
      );
    }

    // 2. Scrolling Logic (Single-line)
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(12),
        constraints: const BoxConstraints(minHeight: 45.0, minWidth: 120.0),
        isSelected: isSelected,
        selectedColor: activeTextColor ?? Theme.of(context).colorScheme.surface,
        fillColor: activeButtonColor ?? Theme.of(context).colorScheme.primary,
        onPressed: onPressed,
        children: buttonLabels,
      ),
    );
  }
}