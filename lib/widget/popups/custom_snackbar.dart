part of '../library.dart';

enum SnackbarType { success, error, warning, info }

class CustomSnackbar {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show({
    required BuildContext context,
    required String message,
    required SnackbarType snackbarType,
    Color? textColor = Colors.white,
    bool? closable = true,
    bool? usesIcon = false,

    ///takes precedent
    int? milisecDuration,

    ///followup if mili is empty
    int? microSecDuration,

    ///last to be considered
    int? secDuration,

    String? actionsLabel,
    VoidCallback? onPressed,
  }) {
    Color getBackgroundColor(SnackbarType type) {
      switch (type) {
        case SnackbarType.success:
          return Colors.green;
        case SnackbarType.error:
          return Colors.red;
        case SnackbarType.warning:
          return Colors.orange;
        case SnackbarType.info:
          return Colors.blue;
      }
    }

    IconData getIcon(SnackbarType type) {
      switch (type) {
        case SnackbarType.success:
          return Icons.check;
        case SnackbarType.error:
          return Icons.error;
        case SnackbarType.warning:
          return Icons.warning;
        case SnackbarType.info:
          return Icons.info;
      }
    }

    Color? snackBarColor = getBackgroundColor(snackbarType);
    IconData? icon = usesIcon == true ? getIcon(snackbarType) : null;
    final messenger = ScaffoldMessenger.of(context);

    messenger.clearSnackBars();
    return messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(12),
        content: Row(
          children: [
            if (icon != null) ...[Icon(icon), const SizedBox(width: 8)],
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: snackBarColor,
        closeIconColor: Colors.red,
        showCloseIcon: closable,
        duration: microSecDuration != null
            ? Duration(microseconds: microSecDuration)
            : milisecDuration != null
            ? Duration(milliseconds: milisecDuration)
            : secDuration != null
            ? Duration(seconds: secDuration)
            : Duration(seconds: 4),
        action: (actionsLabel != null && onPressed != null)
            ? SnackBarAction(label: actionsLabel, onPressed: onPressed)
            : null,
      ),
    );
  }
}
