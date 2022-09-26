import 'package:flutter/cupertino.dart';

class Todo extends ChangeNotifier {
  DateTime? id;
  String? title;
  String? description;
  String? date;
  int? color;
  bool isTodoDone;
  bool isDarkMode;
  Todo(
      {this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.color,
      this.isDarkMode = false,
      this.isTodoDone = false});
  void isToggleTodo() {
    isTodoDone = !isTodoDone;
    notifyListeners();
  }

  void isToggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
