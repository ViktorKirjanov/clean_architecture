import 'package:flutter/material.dart';

class TriviaButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const TriviaButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        onPressed: () => onPressed(),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
