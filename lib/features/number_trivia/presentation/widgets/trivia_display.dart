import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter/material.dart';

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia trivia;

  const TriviaDisplay({
    Key? key,
    required this.trivia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Text(
            trivia.number.toString(),
            style: const TextStyle(
                fontSize: 48.0,
                color: Colors.blue,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: Center(
              child: Text(
                trivia.text,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
