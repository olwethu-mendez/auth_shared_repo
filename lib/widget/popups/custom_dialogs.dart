part of '../library.dart';

class CustomDialogs {
  static Future<bool?> showActionDialog({
    required BuildContext context,
    required String title,
    required String text,
    required String confirmText,
    required VoidCallback onConfirm,
    Color? confirmColor,
    String? cancelText,
    VoidCallback? onCancel,
    bool isDestructive = false,
  }) {
    return showAdaptiveDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: () {
                if (onCancel != null) onCancel();
                Navigator.pop(context, false);
              },
              child: Text(cancelText,
              style: TextStyle(color: Colors.grey),
            ),
            ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context, true);
            },
            child: Text(
              confirmText,
              style: TextStyle(color: isDestructive ? Colors.red : confirmColor ?? Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
