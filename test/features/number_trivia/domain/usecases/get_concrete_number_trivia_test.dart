import 'package:clean_architecture/core/errors/failures.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

// void main() {
//   late GetConcreteNumberTrivia usecase;
//   late MockNumberTriviaRepository mockNumberTriviaRepository;

//   setUp(() {
//     mockNumberTriviaRepository = MockNumberTriviaRepository();
//     usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
//   });

//   const tNumber = 1;
//   const tNumberTrivia = NumberTrivia(number: 1, text: 'test');

//   test(
//     'should get trivia for the number from the repository',
//     () async {
//       // arrange
//       when(mockNumberTriviaRepository.getConcreteNumberTrivia(number: tNumber))
//           .thenAnswer((_) async => const Right(tNumberTrivia));
//       // act
//       final result = await usecase.execute(number: tNumber);
//       // assert
//       expect(result, const Right(tNumberTrivia));
//       verify(
//           mockNumberTriviaRepository.getConcreteNumberTrivia(number: tNumber));
//       verifyNoMoreInteractions(mockNumberTriviaRepository);
//     },
//   );
// }

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test(
    'should get trivia for the number from the repository',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      // act
      final result = await usecase.execute(number: tNumber);
      // assert
      expect(result, const Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );

  test(
    'should fail',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await usecase.execute(number: tNumber);
      // assert
      expect(result, Left(ServerFailure()));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}