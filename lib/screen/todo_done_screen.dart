import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/ui/text_style.dart';

import '../controller/todo_controller.dart';
import '../item/todo_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  Todo get todoProvider => context.read<Todo>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: todoProvider.isDarkMode ? Colors.black : Colors.white,
        body: Container(
          margin: const EdgeInsets.only(left: 10.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
                color: todoProvider.isDarkMode ? Colors.white : Colors.black,
              ),
              Center(
                  child: Column(
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Todo done',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: todoProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                        fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 30.0, top: 40.0, right: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<TodoController>(
                              builder: ((context, value, child) {
                            return value.listCheck.isEmpty
                                ? Center(
                                    child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Image(
                                        height: 100,
                                        width: 100,
                                        image: AssetImage(
                                            'assets/cancellation.png'),
                                      ),
                                      const SizedBox(height: 30),
                                      Text(
                                        "You don't have note done",
                                        style: MyTextStyle(
                                                isDarkTheme:
                                                    todoProvider.isDarkMode)
                                            .titleStyle,
                                      )
                                    ],
                                  ))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: value.listCheck.length,
                                    itemBuilder: ((context, index) {
                                      return TodoItem(
                                        todo: value.listCheck[index],
                                        index: index,
                                      );
                                    }));
                          }))
                        ],
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ));
  }
}
