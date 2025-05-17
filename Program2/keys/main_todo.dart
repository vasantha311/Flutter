import 'package:flutter/material.dart';
import 'package:program1/keys/keys.dart';

import 'package:program1/keys/ui_updates_demo.dart';

void main() {
  var numbers = [1,2,3];
  numbers.add(4);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Internals'),
        ),
        body: const Keys(),
      ),
    );
  }
}