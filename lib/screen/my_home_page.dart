import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/screen/todo_done_screen.dart';
import 'package:todo_app/ui/my_themes.dart';
import 'package:todo_app/ui/text_style.dart';

import '../item/todo_item.dart';
import 'add_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TodoController get _read => context.read<TodoController>();
  TodoController get _watch => context.watch<TodoController>();
  Todo get todoProvider => context.read<Todo>();

  IconData _iconLight = Icons.wb_sunny;
  IconData _iconDark = Icons.nights_stay;

  void _seacrh(String v) {
    setState(() {
      _read.findByTitle(v);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: todoProvider.isDarkMode ? Colors.black : Colors.white,
      body: Container(
          margin: const EdgeInsets.only(left: 18.0, top: 10, right: 18.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        todoProvider.isToggleTheme();
                        // print(todoProvider.isDarkMode);
                      });
                    },
                    icon: Icon(
                      todoProvider.isDarkMode ? _iconLight : _iconDark,
                      color: Colors.red,
                    )),
                IconButton(
                    onPressed: () {
                      _showMenus();
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.red,
                    )),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: TextField(
                style: TextStyle(
                    color:
                        todoProvider.isDarkMode ? Colors.white : Colors.black),
                onChanged: (value) => _seacrh(value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  label: Text(
                    "Seacrh by title",
                    style: TextStyle(
                        color: todoProvider.isDarkMode
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              child:
                  Consumer<TodoController>(builder: ((context, value, child) {
                if (value.getTodo.isEmpty) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                        height: 100,
                        width: 100,
                        image: AssetImage('assets/notes.png'),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "You don't have note",
                        style: TextStyle(
                            color: todoProvider.isDarkMode
                                ? Colors.white
                                : Colors.black),
                      )
                    ],
                  ));
                }
                return value.rs.isEmpty == true
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Image(
                            height: 100,
                            width: 100,
                            image: AssetImage('assets/sad.png'),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            "Sorry, i don't found your search",
                            style: TextStyle(
                                color: todoProvider.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                          )
                        ],
                      ))
                    : ListView.builder(
                        itemCount: value.rs.length,
                        itemBuilder: ((context, index) {
                          return TodoItem(
                            todo: value.rs[index],
                            index: index,
                          );
                        }));
              })),
            )
          ])),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create note',
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddScreen()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  _showMenus() {
    showMenu(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: context,
      position: const RelativeRect.fromLTRB(100.0, 50.0, 0.0, 0.0),
      items: [
        PopupMenuItem(
          textStyle: MyTextStyle(isDarkTheme: todoProvider.isDarkMode).subStyle,
          child: Column(
            children: <Widget>[
              PopupMenuItem(
                child: TextButton(
                    onPressed: () {
                      _read.sortAscending();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Sort a-z',
                      style: TextStyle(color: Colors.red),
                    )),
              ),
              PopupMenuItem(
                child: TextButton(
                    onPressed: () {
                      _read.sortNewest();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Sort newest',
                      style: TextStyle(color: Colors.red),
                    )),
              ),
              PopupMenuItem(
                child: TextButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      _read.getTodoDone();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const TodoScreen())));
                    },
                    // ignore: prefer_const_constructors
                    child: Text(
                      'Todo done',
                      style: const TextStyle(color: Colors.red),
                    )),
              ),
              PopupMenuItem(
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _read.deleteAllItem();
                    },
                    // ignore: prefer_const_constructors
                    child: Text(
                      'Delete all note',
                      style: const TextStyle(color: Colors.red),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
