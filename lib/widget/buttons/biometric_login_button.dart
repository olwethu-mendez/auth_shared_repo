part of '../library.dart';

class BiometricLoginButton extends StatefulWidget {
  const BiometricLoginButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final Function() onPressed;
  final Widget icon;

  @override
  State<BiometricLoginButton> createState() => _BiometricLoginButtonState();
}

class _BiometricLoginButtonState extends State<BiometricLoginButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: widget.onPressed,
        icon: widget.icon,
        label: const Text("Login with Biometrics"),
      ),
    );
  }
}
