import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/screen/detail_screen.dart';
import 'package:todo_app/ui/color.dart';
import 'package:todo_app/ui/text_style.dart';

import '../model/todo.dart';

class TodoItem extends StatefulWidget {
  final Todo? todo;
  final int index;
  const TodoItem({super.key, required this.todo, required this.index});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  TodoController get _read => context.read<TodoController>();
  Todo get todoProvider => context.read<Todo>();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: GetColor.getColor(widget.todo?.color ?? 0),
          child: ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    DetailScreen(todo: widget.todo, index: widget.index))),
            trailing: IconButton(
                onPressed: () {
                  // print(widget.todo!.isTodoDone);
                  setState(() {
                    widget.todo?.isToggleTodo();
                  });
                },
                icon: Icon(
                  widget.todo!.isTodoDone
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank,
                )),
            leading: const Icon(Icons.event_note),
            title: Text(
              '${widget.todo?.title}',
              style:
                  MyTextStyle(isDarkTheme: todoProvider.isDarkMode).titleStyle,
            ),
            subtitle: Text('${widget.todo?.description}'),
          ),
        ));
  }
}
