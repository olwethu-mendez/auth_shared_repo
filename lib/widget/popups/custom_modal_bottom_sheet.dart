part of '../library.dart';

class CustomModalBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget child,
    List<Widget>? actions,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) => Column(
            // Use Column instead of ListView
            mainAxisSize: MainAxisSize.min, // Allows the sheet to wrap content
            children: [
              /// HEADER
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              /// CONTENT
              // Use Expanded + ListView to make the middle scrollable while pushing actions down
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  children: [child],
                ),
              ),

              /// ACTIONS
              if (actions != null) ...[
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 8, // Adds uniform space between buttons
                    children: actions,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
