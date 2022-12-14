import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
}
