import 'package:flutter/cupertino.dart';

import '../model/todo.dart';

class TodoController extends ChangeNotifier {
  // ignore: unused_field
  List<Todo> _mListTodo = <Todo>[];
  List<Todo> get getTodo => _mListTodo;
  late List<Todo> _results = _mListTodo;
  List<Todo> get rs => _results;
  List<Todo> check = [];
  List<Todo> get listCheck => check;

  void addTodo(
      DateTime id, String title, String description, String date, int? color) {
    Todo todo = Todo(
        id: DateTime.now(),
        title: title,
        description: description,
        date: date,
        color: color);
    _mListTodo.add(todo);
    notifyListeners();
  }

  void deleteTodo(Todo? todo) {
    _mListTodo.remove(todo);
    notifyListeners();
  }

  void upDateTodo(
      int position, String title, String description, String date, int? color) {
    _mListTodo[position].title = title;
    _mListTodo[position].description = description;
    _mListTodo[position].date = date;
    _mListTodo[position].color = color;
    notifyListeners();
  }

  void findByTitle(String search) {
    if (search.isEmpty) {
      _results = _mListTodo;
    } else {
      _results = _mListTodo
          .where((element) =>
              element.title!.toLowerCase().contains(search.toLowerCase()))
          .toList();

      notifyListeners();
    }
  }

  void sortAscending() {
    _mListTodo.sort((a, b) => a.title!.compareTo(b.title!));
    notifyListeners();
  }

  void sortNewest() {
    _mListTodo.sort((a, b) => b.id!.compareTo(a.id!));
    notifyListeners();
  }

  void getTodoDone() {
    check = _mListTodo.where((element) => element.isTodoDone ?? false).toList();
    notifyListeners();
  }

  void deleteAllItem() {
    _mListTodo.clear();
    notifyListeners();
  }
}
