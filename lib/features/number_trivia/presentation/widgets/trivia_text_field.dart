import 'package:flutter/material.dart';

class TriviaTextField extends StatelessWidget {
  final TextEditingController controller;

  const TriviaTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input a number',
      ),
    );
  }
}
