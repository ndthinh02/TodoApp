import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/text_style.dart';

import '../model/todo.dart';

class MyInputField extends StatefulWidget {
  final String title;
  final String hint;
  TextEditingController? textEditingController;
  Widget? widget;
  MyInputField(
      {super.key,
      required this.title,
      required this.hint,
      this.widget,
      this.textEditingController});

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  Todo get todoProvider => context.read<Todo>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title,
              style:
                  MyTextStyle(isDarkTheme: todoProvider.isDarkMode).titleStyle),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 10),
            height: 52,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(13)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget.widget == null ? false : true,
                    autofocus: false,
                    controller: widget.textEditingController,
                    cursorColor:
                        todoProvider.isDarkMode ? Colors.white : Colors.black,
                    style: MyTextStyle(isDarkTheme: todoProvider.isDarkMode)
                        .subStyle,
                    decoration: InputDecoration(
                        hintText: widget.hint,
                        hintStyle:
                            MyTextStyle(isDarkTheme: todoProvider.isDarkMode)
                                .subStyle,
                        border: InputBorder.none),
                  ),
                ),
                widget.widget == null
                    ? Container()
                    : Container(child: widget.widget)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
