import 'package:clean_architecture/core/errors/failures.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRandomTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late GetRandomNumberTrivia usecase;
  late MockRandomTriviaRepository mockRandomTriviaRepository;

  setUp(() {
    mockRandomTriviaRepository = MockRandomTriviaRepository();
    usecase = GetRandomNumberTrivia(mockRandomTriviaRepository);
  });

  const tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test(
    'should get trivia from the repository',
    () async {
      // arrange
      when(mockRandomTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => const Right(tNumberTrivia));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, const Right(tNumberTrivia));
      verify(mockRandomTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockRandomTriviaRepository);
    },
  );

  test(
    'should fail',
    () async {
      // arrange
      when(mockRandomTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Left(ServerFailure()));
      verify(mockRandomTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockRandomTriviaRepository);
    },
  );
}
