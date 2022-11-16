import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const triviaDisplayKey = Key('triviaDisplayKey');
  const int triviaNumber = 1;
  const String triviaText = 'Lorem ipsum text';

  testWidgets('TriviaButton', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: TriviaDisplay(
          key: triviaDisplayKey,
          trivia: NumberTrivia(
            number: triviaNumber,
            text: triviaText,
          ),
        ),
      ),
    ));

    expect(find.byKey(triviaDisplayKey), findsOneWidget);
    expect(find.text(triviaNumber.toString()), findsOneWidget);
    expect(find.text(triviaText), findsOneWidget);
  });
}
