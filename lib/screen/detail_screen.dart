import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/screen/my_home_page.dart';
import 'package:todo_app/screen/update_screen.dart';
import 'package:todo_app/ui/color.dart';
import 'package:todo_app/ui/text_style.dart';

import '../model/todo.dart';

class DetailScreen extends StatefulWidget {
  final Todo? todo;
  final int? index;
  const DetailScreen({super.key, required this.todo, required this.index});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  TodoController get _readController => context.read<TodoController>();
  Todo get _todoProvider => context.read<Todo>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _todoProvider.isDarkMode ? Colors.black : Colors.white,
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
                color: _todoProvider.isDarkMode ? Colors.white : Colors.black,
              ),
              Center(
                  child: Column(
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Hello',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _todoProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                        fontSize: 24),
                  ),
                  Text('You have new note',
                      style: TextStyle(
                        color: _todoProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      )),
                  const SizedBox(height: 20),
                  Container(
                    width: 300,
                    height: 400,
                    decoration: BoxDecoration(
                        color: GetColor.getColor(widget.todo?.color ?? 0),
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 30.0, top: 40.0, right: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title',
                              style: MyTextStyle(
                                      isDarkTheme: _todoProvider.isDarkMode)
                                  .titleStyle),
                          const SizedBox(height: 10),
                          Text('${widget.todo?.title}',
                              style: MyTextStyle(
                                      isDarkTheme: _todoProvider.isDarkMode)
                                  .subStyle),
                          const SizedBox(height: 10),
                          Text('Desciption',
                              style: MyTextStyle(
                                      isDarkTheme: _todoProvider.isDarkMode)
                                  .titleStyle),
                          const SizedBox(height: 10),
                          Text('${widget.todo?.description}',
                              style: MyTextStyle(
                                      isDarkTheme: _todoProvider.isDarkMode)
                                  .subStyle),
                          const SizedBox(height: 10),
                          Text('Date create note',
                              style: MyTextStyle(
                                      isDarkTheme: _todoProvider.isDarkMode)
                                  .titleStyle),
                          const SizedBox(height: 10),
                          Text('${widget.todo?.date}',
                              style: MyTextStyle(
                                      isDarkTheme: _todoProvider.isDarkMode)
                                  .subStyle),
                          const SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      _showMyDialog(context);
                                    },
                                    icon: const Icon(Icons.delete)),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (ctx) => UpdateScreen(
                                                    position: widget.index,
                                                  )));
                                    },
                                    icon: const Icon(Icons.edit))
                              ])
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

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notifications'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Would you like to delete note ?'),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    _readController.deleteTodo(widget.todo);
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                ),
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
