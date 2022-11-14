part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetConcreteTrivia extends NumberTriviaEvent {
  final String numberString;

  const GetConcreteTrivia(this.numberString);

  @override
  List<Object> get props => [numberString];
}

class GetRandomTrivia extends NumberTriviaEvent {}
