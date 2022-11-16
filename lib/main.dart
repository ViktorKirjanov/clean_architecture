import 'package:flutter/material.dart';
import 'dependency_injection.dart' as di;
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clear Achecture',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NumberTriviaPage(),
    );
  }
}
