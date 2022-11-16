import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';
import 'trivia_button.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({super.key});

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TriviaTextField(controller: _textEditingController),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: TriviaButton(
                key: const Key('randomTriviaButtonKey'),
                title: 'Random',
                onPressed: () {
                  _textEditingController.clear();
                  BlocProvider.of<NumberTriviaBloc>(context)
                      .add(GetRandomTrivia());
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: TriviaButton(
                key: const Key('searchTriviaButtonKey'),
                title: 'Search',
                onPressed: (() {
                  BlocProvider.of<NumberTriviaBloc>(context)
                      .add(GetConcreteTrivia(_textEditingController.text));
                  _textEditingController.clear();
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
