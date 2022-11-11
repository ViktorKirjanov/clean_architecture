import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('supports value comparison', () {
    expect(
      const NumberTrivia(number: 1, text: 'text'),
      const NumberTrivia(number: 1, text: 'text'),
    );
  });
}
