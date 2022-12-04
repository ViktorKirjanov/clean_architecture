import 'package:clean_architecture/dependency_injection.dart';
import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/loadong_indicator.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Number Trivia'),
        ),
        body: _buildBody(context),
      );

  Widget _buildBody(BuildContext context) => BlocProvider(
        create: (_) => getIt<NumberTriviaBloc>(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return const MessageDisplay(message: 'Start searching!');
                  } else if (state is Loading) {
                    return const LoadingIndicator();
                  } else if (state is Loaded) {
                    return TriviaDisplay(trivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                  return const MessageDisplay(
                    message: 'Something went wrong. Please try again.',
                  );
                },
              ),
              const SizedBox(height: 10.0),
              const TriviaControls(),
            ],
          ),
        ),
      );
}
