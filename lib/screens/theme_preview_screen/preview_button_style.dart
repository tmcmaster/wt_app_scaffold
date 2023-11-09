import 'package:flutter/material.dart';

typedef ButtonPreviewBuilder = Widget Function(String);

class PreviewButtonStyles extends StatelessWidget {
  static final buttons = <String, ButtonPreviewBuilder>{
    'Elevated Button': (label) => ElevatedButton(
          onPressed: () {},
          child: Text(label),
        ),
    'Text Button': (label) => TextButton(
          onPressed: () {},
          child: Text(label),
        ),
    'Outline Button': (label) => OutlinedButton(
          onPressed: () {},
          child: Text(label),
        ),
    'Icon Button': (label) => IconButton(
          onPressed: () {},
          icon: const Icon(Icons.home),
        ),
    'Floating Action Button': (label) => FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.home),
        ),
  };
  const PreviewButtonStyles({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: buttons.entries
          .map(
            (button) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: button.value(button.key),
            ),
          )
          .toList(),
    );
  }
}
