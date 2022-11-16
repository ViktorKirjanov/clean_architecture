import 'package:clean_architecture/core/errors/failures.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/core/util/input_converter.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean_architecture/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  const tNumber = 123;
  const tText = 'Lorem ipsum';
  const tNumberTrivia = NumberTrivia(number: tNumber, text: tText);
  const randomTriviaButtonKey = Key('randomTriviaButtonKey');
  const searchTriviaButtonKey = Key('searchTriviaButtonKey');

  group('test ScoreListItem', () {
    late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
    late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
    late MockInputConverter mockInputConverter;

    final getIt = GetIt.instance;

    getIt.registerFactory(
      () => NumberTriviaBloc(
        concrete: mockGetConcreteNumberTrivia,
        inputConverter: mockInputConverter,
        random: mockGetRandomNumberTrivia,
      ),
    );

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
      mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
      mockInputConverter = MockInputConverter();
    });

    testWidgets(
      'should find init widgets',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: NumberTriviaPage(),
            ),
          ),
        );

        expect(find.text('Number Trivia'), findsOneWidget);
        expect(find.text('Start searching!'), findsOneWidget);
        expect(find.byType(MessageDisplay), findsOneWidget);
        expect(find.byType(TriviaControls), findsOneWidget);
      },
    );

    group('random trivia', () {
      testWidgets(
        'should get trivia from the usecase',
        (WidgetTester tester) async {
          when(() => mockGetRandomNumberTrivia.call(NoParams())).thenAnswer(
            (_) async => const Right(tNumberTrivia),
          );

          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: NumberTriviaPage(),
              ),
            ),
          );

          await tester.tap(find.byKey(randomTriviaButtonKey));
          await tester.pump();
          expect(find.byType(TriviaDisplay), findsOneWidget);
          expect(find.text(tNumber.toString()), findsOneWidget);
          expect(find.text(tText), findsOneWidget);
        },
      );

      testWidgets(
        'should get ServerFailure from the usecase',
        (WidgetTester tester) async {
          when(() => mockGetRandomNumberTrivia.call(NoParams())).thenAnswer(
            (_) async => Left(ServerFailure()),
          );

          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: NumberTriviaPage(),
              ),
            ),
          );

          await tester.tap(find.byKey(randomTriviaButtonKey));
          await tester.pump();
          expect(find.byType(MessageDisplay), findsOneWidget);
          expect(find.text(serverFailureMessage), findsOneWidget);
        },
      );

      testWidgets(
        'should get CacheFailure from the usecase',
        (WidgetTester tester) async {
          when(() => mockGetRandomNumberTrivia.call(NoParams())).thenAnswer(
            (_) async => Left(CacheFailure()),
          );

          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: NumberTriviaPage(),
              ),
            ),
          );
          await tester.tap(find.byKey(randomTriviaButtonKey));
          await tester.pump();
          expect(find.byType(MessageDisplay), findsOneWidget);
          expect(find.text(cacheFailureMessage), findsOneWidget);
        },
      );
    });

    group('concrete trivia', () {
      testWidgets(
        'should get trivia from the usecase',
        (WidgetTester tester) async {
          when(() => mockGetConcreteNumberTrivia.call
              .call(const Params(number: tNumber))).thenAnswer(
            (_) async => const Right(tNumberTrivia),
          );

          when(() => mockInputConverter.stringToUnsignedInteger(
              tNumber.toString())).thenReturn(const Right(tNumber));

          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: NumberTriviaPage(),
              ),
            ),
          );

          await tester.enterText(find.byType(TextField), tNumber.toString());
          await tester.tap(find.byKey(searchTriviaButtonKey));
          await tester.pump();
          expect(find.byType(TriviaDisplay), findsOneWidget);
          expect(find.text(tNumber.toString()), findsOneWidget);
          expect(find.text(tText), findsOneWidget);
        },
      );

      testWidgets(
        'should get ServerFailure from the usecase',
        (WidgetTester tester) async {
          when(() => mockGetConcreteNumberTrivia
              .call(const Params(number: tNumber))).thenAnswer(
            (_) async => Left(ServerFailure()),
          );

          when(() => mockInputConverter.stringToUnsignedInteger(
              tNumber.toString())).thenReturn(const Right(tNumber));

          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: NumberTriviaPage(),
              ),
            ),
          );
          await tester.enterText(find.byType(TextField), tNumber.toString());
          await tester.tap(find.byKey(searchTriviaButtonKey));
          await tester.pump();
          expect(find.byType(MessageDisplay), findsOneWidget);
          expect(find.text(serverFailureMessage), findsOneWidget);
        },
      );

      testWidgets(
        'should get CacheFailure from the usecase',
        (WidgetTester tester) async {
          when(() => mockGetConcreteNumberTrivia
              .call(const Params(number: tNumber))).thenAnswer(
            (_) async => Left(CacheFailure()),
          );

          when(() => mockInputConverter.stringToUnsignedInteger(
              tNumber.toString())).thenReturn(const Right(tNumber));

          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: NumberTriviaPage(),
              ),
            ),
          );
          await tester.enterText(find.byType(TextField), tNumber.toString());
          await tester.tap(find.byKey(searchTriviaButtonKey));
          await tester.pump();
          expect(find.byType(MessageDisplay), findsOneWidget);
          expect(find.text(cacheFailureMessage), findsOneWidget);
        },
      );
    });
  });
}
