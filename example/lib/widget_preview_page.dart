import 'package:example/widgets/sidelined_header.dart';
import 'package:flutter/material.dart';

class WidgetPreviewPage extends StatelessWidget {
  final String title;
  final Widget preview;
  final List<Widget>? controls;

  const WidgetPreviewPage({
    super.key,
    required this.title,
    required this.preview,
    this.controls,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
                const SizedBox(height: 10),
SidelinedHeader(title: "W I D G E T   P R E V I E W"),

                const SizedBox(height: 20),
              preview,

              if (controls != null) ...[
                const SizedBox(height: 40),
                const Divider(),
                const SizedBox(height: 20),

SidelinedHeader(title: "C O N T R O L S"),

                const SizedBox(height: 20),

                Column(
                  children: controls??[],
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}