import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const triviaButtonKey = Key('triviaButtonKey');
  const title = 'Search';

  testWidgets('TriviaButton', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TriviaButton(
            key: triviaButtonKey,
            title: title,
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.byKey(triviaButtonKey), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.text(title), findsOneWidget);
  });
}
