import 'package:clean_architecture/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const messageDisplayKey = Key('messageDisplayKey');
  const message = 'Lorem ipsum';

  testWidgets('MessageDisplay', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: MessageDisplay(
          key: messageDisplayKey,
          message: message,
        ),
      ),
    ));

    expect(find.byKey(messageDisplayKey), findsOneWidget);
    expect(find.text(message), findsOneWidget);
  });
}
