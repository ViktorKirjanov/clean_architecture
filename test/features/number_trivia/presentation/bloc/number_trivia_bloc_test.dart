// ignore_for_file: prefer_const_constructors, avoid_implementing_value_types

import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture/core/errors/failures.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/core/util/input_converter.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

class FakeParams extends Fake implements Params {}

class FakeNoParams extends Fake implements NoParams {}

void main() {
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    registerFallbackValue(FakeParams());
    registerFallbackValue(FakeNoParams());
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
  });

  NumberTriviaBloc buildBloc() => NumberTriviaBloc(
        concrete: mockGetConcreteNumberTrivia,
        random: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter,
      );

  test('works properly', () {
    expect(buildBloc, returnsNormally);
  });

  test('initialState should be Empty', () {
    // assert
    expect(buildBloc().state, equals(Empty()));
  });

  const tNumberString = '1';
  const tNumberParsed = 1;
  const tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

  group('GetConcreteTrivia', () {
    void setUpMockInputConverterSuccess() =>
        when(() => mockInputConverter.stringToUnsignedInteger(tNumberString))
            .thenReturn(const Right(tNumberParsed));

    void setUpMockGetConcreteTriviaSuccess() =>
        when(() => mockGetConcreteNumberTrivia(any()))
            .thenAnswer((_) async => const Right(tNumberTrivia));

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should call the InputConverter to validate and convert the string to an unsigned integer',
      setUp: () {
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteTriviaSuccess();
      },
      build: buildBloc,
      act: (bloc) async => bloc.add(const GetConcreteTrivia(tNumberString)),
      verify: (_) => verify(
        () => mockInputConverter.stringToUnsignedInteger(tNumberString),
      ).called(1),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Error] when the input is invalid',
      setUp: () {
        when(() => mockInputConverter.stringToUnsignedInteger(any()))
            .thenReturn(Left(InvalidInputFailure()));
      },
      build: buildBloc,
      act: (bloc) async => bloc.add(const GetConcreteTrivia(tNumberString)),
      expect: () => [
        Error(message: invalidInputFailureMessage),
      ],
      verify: (_) => verify(
        () => mockInputConverter.stringToUnsignedInteger(tNumberString),
      ).called(1),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should get data from the concrete use case',
      setUp: () {
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteTriviaSuccess();
      },
      build: buildBloc,
      act: (bloc) async => bloc.add(const GetConcreteTrivia(tNumberString)),
      verify: (_) => verify(
        () => mockGetConcreteNumberTrivia(const Params(number: tNumberParsed)),
      ).called(1),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      setUp: () {
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteTriviaSuccess();
      },
      build: buildBloc,
      act: (bloc) async => bloc.add(const GetConcreteTrivia(tNumberString)),
      expect: () => [
        Loading(),
        Loaded(trivia: tNumberTrivia),
      ],
      verify: (_) => verify(
        () => mockInputConverter.stringToUnsignedInteger(tNumberString),
      ).called(1),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Error] when getting data fails',
      setUp: () {
        setUpMockInputConverterSuccess();
        when(() => mockGetConcreteNumberTrivia(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
      },
      build: buildBloc,
      act: (bloc) async => bloc.add(const GetConcreteTrivia(tNumberString)),
      expect: () => [
        Loading(),
        Error(message: serverFailureMessage),
      ],
      verify: (_) => verify(
        () => mockInputConverter.stringToUnsignedInteger(tNumberString),
      ).called(1),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      setUp: () {
        setUpMockInputConverterSuccess();
        when(() => mockGetConcreteNumberTrivia(any()))
            .thenAnswer((_) async => Left(CacheFailure()));
      },
      build: buildBloc,
      act: (bloc) async => bloc.add(const GetConcreteTrivia(tNumberString)),
      expect: () => [
        Loading(),
        Error(message: cacheFailureMessage),
      ],
      verify: (_) => verify(
        () => mockInputConverter.stringToUnsignedInteger(tNumberString),
      ).called(1),
    );
  });

  group('GetRandomTrivia', () {
    void setUpMockGetRandomTriviaSuccess() =>
        when(() => mockGetRandomNumberTrivia(any()))
            .thenAnswer((_) async => const Right(tNumberTrivia));

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should get data from the random use case',
      setUp: setUpMockGetRandomTriviaSuccess,
      build: buildBloc,
      act: (bloc) async => bloc.add(GetRandomTrivia()),
      verify: (_) => verify(
        () => mockGetRandomNumberTrivia(NoParams()),
      ).called(1),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      setUp: setUpMockGetRandomTriviaSuccess,
      build: buildBloc,
      act: (bloc) async => bloc.add(GetRandomTrivia()),
      expect: () => [
        Loading(),
        Loaded(trivia: tNumberTrivia),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Error] when getting data fails',
      setUp: () {
        when(() => mockGetRandomNumberTrivia(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
      },
      build: buildBloc,
      act: (bloc) async => bloc.add(GetRandomTrivia()),
      expect: () => [
        Loading(),
        Error(message: serverFailureMessage),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      setUp: () {
        when(() => mockGetRandomNumberTrivia(any()))
            .thenAnswer((_) async => Left(CacheFailure()));
      },
      build: buildBloc,
      act: (bloc) async => bloc.add(GetRandomTrivia()),
      expect: () => [
        Loading(),
        Error(message: cacheFailureMessage),
      ],
    );
  });
}
