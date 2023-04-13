import 'package:flutter/material.dart';

class CalculatorStyles {
  static Color buttonBackgroundColor(String value) {
    switch (value) {
      case '+':
      case '-':
      case 'x':
      case '/':
      case '%':
        return const Color.fromARGB(255, 4, 90, 155);

      case 'c':
      case 'del':
      case '=':
        return Colors.white;

      default:
        return const Color.fromARGB(255, 29, 46, 72);
    }
  }

  static Color buttonForegroundColor(String value) {
    switch (value) {
      case 'c':
      case 'del':
        return Colors.red;

      case '=':
        return Colors.black;

      case '+':
      case '-':
      case 'x':
      case '/':
      case '%':
        return const Color.fromARGB(255, 29, 46, 72);

      default:
        return Colors.blue;
    }
  }

  static Color buttonTextColor(String value) {
    switch (value) {
      case 'c':
      case 'del':
        return Colors.red;

      case '=':
        return Colors.black;

      default:
        return Colors.white;
    }
  }

  static double buttonTextSize(String value) {
    switch (value) {
      case '+':
      case '-':
      case 'x':
      case '/':
      case '%':
      case '=':
        return 30;

      default:
        return 25;
    }
  }
}
