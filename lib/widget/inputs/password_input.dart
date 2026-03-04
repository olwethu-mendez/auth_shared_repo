part of '../library.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    required this.passwordController,
    required this.labelText,
  });

  final TextEditingController passwordController;
  final String labelText;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool passwordIsHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        semanticCounterText: "${widget.labelText} input field",
        prefixIcon: Icon(Icons.lock_outline),
        suffix: IconButton(
          onPressed: () => setState(() => passwordIsHidden = !passwordIsHidden),
          icon: Icon(
            passwordIsHidden ? Icons.visibility : Icons.visibility_off,
          ),
          tooltip: passwordIsHidden ? "Show password" : "Hide password",
        ),
      ),
      obscureText: passwordIsHidden ? true : false,
    );
  }
}
