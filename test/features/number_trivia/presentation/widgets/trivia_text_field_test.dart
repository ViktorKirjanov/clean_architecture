import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const triviaTextFieldKey = Key('triviaTextFieldKey');
  const searchTrivia = '123';

  testWidgets('TriviaTextField', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TriviaTextField(
            key: triviaTextFieldKey,
            controller: TextEditingController(),
          ),
        ),
      ),
    );

    final finder = find.byKey(triviaTextFieldKey);

    expect(finder, findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Input a number'), findsOneWidget);

    await tester.enterText(finder, searchTrivia);
    await tester.pump();
    expect(find.text(searchTrivia), findsOneWidget);
  });
}
