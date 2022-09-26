import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/screen/my_home_page.dart';
import 'package:todo_app/ui/my_themes.dart';

import 'model/todo.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TodoController()),
          ChangeNotifierProvider(
              create: (context) =>
                  Todo(color: null, date: '', description: '', title: ''))
        ],
        child: Builder(builder: (BuildContext context) {
          return const MyApp();
        })),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: MyHomePage(
          title: 'Todo List',
        ));
  }
}
