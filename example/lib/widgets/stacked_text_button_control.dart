import 'package:flutter/material.dart';

class StackedTextButtonControl extends StatefulWidget {
  const StackedTextButtonControl({super.key, required this.textLabel, required this.buttonLabel, required this.textEditingController, required this.onPressed});

  final TextEditingController textEditingController;
  final Function() onPressed;
  final String textLabel;
  final Widget buttonLabel;

  @override
  State<StackedTextButtonControl> createState() => _StackedTextButtonControlState();
}

class _StackedTextButtonControlState extends State<StackedTextButtonControl> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [        
          TextField(
            decoration: InputDecoration(labelText: widget.textLabel),
            controller: widget.textEditingController,
          ),

          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onPressed,
              child: widget.buttonLabel,
            ),
          )
      ],
    );
  }
}