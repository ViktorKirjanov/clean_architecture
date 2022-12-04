import 'package:clean_architecture/dependency_injection.dart' as di;
import 'package:clean_architecture/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Clear Achecture',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NumberTriviaPage(),
      );
}
