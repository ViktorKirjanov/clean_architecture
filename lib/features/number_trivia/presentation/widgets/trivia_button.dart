import 'package:flutter/material.dart';

class TriviaButton extends StatelessWidget {
  const TriviaButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 50.0,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          onPressed: onPressed,
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
