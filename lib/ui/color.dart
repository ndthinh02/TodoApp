import 'package:flutter/material.dart';

class GetColor {
  static getColor(int index) {
    switch (index) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.green;
      case 2:
        return Colors.deepOrangeAccent;
      case 3:
        return Colors.deepPurpleAccent;
      case 4:
        return Colors.tealAccent;
      case 5:
        return Colors.brown;
    }
  }
}
