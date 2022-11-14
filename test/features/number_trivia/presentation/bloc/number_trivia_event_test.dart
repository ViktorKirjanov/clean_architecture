// ignore_for_file: prefer_const_constructors

import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NumberTriviaEvent', () {
    group('GetConcreteTrivia', () {
      test('supports value equality', () {
        expect(
          GetConcreteTrivia('123'),
          equals(GetConcreteTrivia('123')),
        );
      });

      test('props are correct', () {
        expect(GetConcreteTrivia('123').props, equals(<Object?>['123']));
      });
    });

    group('GetRandomTrivia', () {
      test('supports value equality', () {
        expect(
          GetRandomTrivia(),
          equals(GetRandomTrivia()),
        );
      });

      test('props are correct', () {
        expect(GetRandomTrivia().props, equals(<Object?>[]));
      });
    });
  });
}
