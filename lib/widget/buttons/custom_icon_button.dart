part of '../library.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.isSubmitting = false,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final String label;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: isSubmitting ? null : onPressed,
        label: Text(isSubmitting ? '' : label),
        icon: isSubmitting
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator.adaptive(strokeWidth: 2),
              )
            : icon,
      ),
    );
  }
}
