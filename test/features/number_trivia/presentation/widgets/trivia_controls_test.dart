import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_button.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const triviaControlsKey = Key('triviaControlsKey');

  testWidgets('TriviaControls', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: TriviaControls(
            key: triviaControlsKey,
          ),
        ),
      ),
    );

    expect(find.byKey(triviaControlsKey), findsOneWidget);
    expect(find.byType(TriviaTextField), findsOneWidget);
    expect(find.byType(TriviaButton), findsNWidgets(2));
  });
}
