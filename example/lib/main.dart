import 'package:flutter/material.dart';
import 'widget_gallery.dart';

void main(){
  runApp(const AuthSharedExamples());
}

class AuthSharedExamples extends StatelessWidget {
  const AuthSharedExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WidgetGallery(),
    );
  }
}