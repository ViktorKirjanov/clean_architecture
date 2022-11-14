// ignore_for_file: prefer_const_constructors

import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NumberTriviaState', () {
    test('Empty supports value comparison', () {
      expect(Empty(), Empty());
    });

    test('Loading supports value comparison', () {
      expect(Loading(), Loading());
    });

    test('Loaded supports value comparison', () {
      expect(
        NumberTrivia(number: 123, text: 'text trivia'),
        NumberTrivia(number: 123, text: 'text trivia'),
      );
    });

    test('Error supports value comparison', () {
      expect(
        Error(message: 'error'),
        Error(message: 'error'),
      );
    });
  });
}
