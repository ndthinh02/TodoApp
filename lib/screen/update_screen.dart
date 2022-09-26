import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/ui/input_field.dart';

import '../model/todo.dart';
import '../ui/text_style.dart';

class UpdateScreen extends StatefulWidget {
  final int? position;
  static String routeName = '/Add';

  const UpdateScreen({super.key, required this.position});

  @override
  State<UpdateScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UpdateScreen> {
  String titleApp = 'Add Note';
  DateTime _selectedDate = DateTime.now();
  int? _selectedColor;
  final _titleController = TextEditingController();
  final _descriptonController = TextEditingController();
  final _dateController = TextEditingController();
  late String title = _titleController.text;
  late String descripton = _descriptonController.text;
  Todo get todoProvider => context.read<Todo>();

  TodoController get _read => context.read<TodoController>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor:
              todoProvider.isDarkMode ? Colors.black : Colors.white,
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                    color:
                        todoProvider.isDarkMode ? Colors.white : Colors.black,
                  ),
                  const SizedBox(height: 18.0),
                  Text(
                    'Update note',
                    style: MyTextStyle(isDarkTheme: todoProvider.isDarkMode)
                        .titleStyle,
                  ),
                  MyInputField(
                    title: 'Title',
                    hint: 'Enter title',
                    textEditingController: _titleController,
                  ),
                  MyInputField(
                      title: 'Desciption',
                      hint: 'Enter desciption',
                      textEditingController: _descriptonController),
                  MyInputField(
                    textEditingController: _dateController,
                    title: 'Date',
                    hint: DateFormat.yMd().format(_selectedDate),
                    widget: IconButton(
                        icon: Icon(
                          Icons.calendar_today_outlined,
                          color: todoProvider.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                        onPressed: () {
                          _getDatePicker(context);
                        }),
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _color(),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ))),
                          onPressed: () {
                            _validateForm();
                          },
                          child: const Text('Update '))
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  const Center(
                      child: Flexible(
                    child: Image(
                      image: AssetImage('assets/update.png'),
                      width: 200,
                      height: 200,
                    ),
                  ))
                ],
              ),
            ),
          )),
    );
  }

  _validateForm() {
    if (_titleController.text.isNotEmpty &&
        _descriptonController.text.isNotEmpty) {
      _read.upDateTodo(widget?.position ?? 0, title, descripton,
          DateFormat.yMd().format(_selectedDate), _selectedColor);
      Navigator.of(context).pushReplacementNamed('/');
      Get.back();
    }
    if (_titleController.text.isEmpty || _descriptonController.text.isEmpty) {
      Get.snackbar('Required ', 'All fields are requied !',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    }
  }

  _getDatePicker(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2100));
    if (datePicker != null) {
      setState(() {
        _selectedDate = datePicker;
      });
    } else {
      print('date wrong');
    }
  }

  _color() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: MyTextStyle(isDarkTheme: todoProvider.isDarkMode).titleStyle,
        ),
        Wrap(
          children: List<Widget>.generate(
              6,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = index;
                      });
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8),
                        child: CircleAvatar(
                            // ignore: sort_child_properties_last
                            child: _selectedColor == index
                                ? const Icon(
                                    Icons.done,
                                    size: 13,
                                  )
                                : Container(),
                            radius: 10,
                            backgroundColor: index == 0
                                ? Colors.red
                                : index == 1
                                    ? Colors.green
                                    : index == 2
                                        ? Colors.deepOrangeAccent
                                        : index == 3
                                            ? Colors.deepPurpleAccent
                                            : index == 4
                                                ? Colors.tealAccent
                                                : index == 5
                                                    ? Colors.brown
                                                    : Colors.deepOrange)),
                  )),
        )
      ],
    );
  }
}
