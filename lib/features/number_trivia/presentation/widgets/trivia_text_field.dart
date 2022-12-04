import 'package:flutter/material.dart';

class TriviaTextField extends StatelessWidget {
  const TriviaTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Input a number',
        ),
      );
}
