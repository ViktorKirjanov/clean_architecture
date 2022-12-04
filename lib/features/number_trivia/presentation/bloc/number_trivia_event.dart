part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetConcreteTrivia extends NumberTriviaEvent {
  const GetConcreteTrivia(this.numberString);

  final String numberString;

  @override
  List<Object> get props => [numberString];
}

class GetRandomTrivia extends NumberTriviaEvent {}
