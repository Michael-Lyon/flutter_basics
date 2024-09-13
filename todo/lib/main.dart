import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo/app/locator.dart';
import 'package:todo/models/todo.adapter.dart';
import 'package:todo/ui/todos_screen/todos_screen_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox("todos");

  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TodoScreenView(),
      theme: ThemeData.dark(),
      title: "Flutter Stacked Practice",
    );
  }
}
