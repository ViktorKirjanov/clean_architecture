import 'package:clean_architecture/features/number_trivia/presentation/widgets/loadong_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const loadingIndicatorKey = Key('loadingIndicatorKey');

  testWidgets('LoadingIndicator', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LoadingIndicator(
            key: loadingIndicatorKey,
          ),
        ),
      ),
    );

    expect(find.byKey(loadingIndicatorKey), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
