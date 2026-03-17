import 'package:flutter/material.dart';

class InlineTextButtonControl extends StatefulWidget {
  const InlineTextButtonControl({
    super.key,
    required this.textEditingController,
    required this.onPressed, required this.textLabel, required this.buttonLabel
  });

  final TextEditingController textEditingController;
  final Function() onPressed;
  final String textLabel;
  final Widget buttonLabel;

  @override
  State<InlineTextButtonControl> createState() =>
      _InlineTextButtonControlState();
}

class _InlineTextButtonControlState extends State<InlineTextButtonControl> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(labelText: widget.textLabel),
            controller: widget.textEditingController,
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: widget.onPressed,
          child: widget.buttonLabel,
        ),
      ],
    );
  }
}
