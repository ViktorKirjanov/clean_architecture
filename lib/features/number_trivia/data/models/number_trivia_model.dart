import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required String text,
    required int number,
  }) : super(
          text: text,
          number: number,
        );

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      NumberTriviaModel(
        text: json['text'] as String,
        number: json['number'] is double
            ? (json['number'] as double).toInt()
            : json['number'] as int,
      );

  Map<String, dynamic> toJson() => {'text': text, 'number': number};
}
