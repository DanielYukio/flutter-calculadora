import 'package:flutter/material.dart';

enum Operations { add, subtract, multiply, divide, percent }

class Calculator {
  late double? n1;
  late double? n2;
  late double? result;
  late String? operation;
  late String displayValue = '0';

  Calculator();

  void setValue(String value) {
    if (double.tryParse(value) != null) {
      setNumber(value);
    } else {
      switch (value) {
        case '+':
        case '-':
        case '*':
        case '/':
        case '%':
          setOperation(value);
          break;

        case '=':
          setResult();
          break;

        case '+/-':
          if (double.parse(displayValue) > 0) {
            displayValue = '-' + displayValue;
          } else if (double.parse(displayValue) < 0) {
            displayValue = displayValue.substring(1);
          } else {
            return;
          }
          break;

        case '.':
          break;

        case 'c':
          delete(clearAll: true);
          break;

        case 'del':
          delete();
          break;

        default:
          break;
      }
    }
  }

  void setNumber(String value) {
    if (displayValue == '0') {
      displayValue = value;
    } else {
      displayValue += value;
    }
  }

  delete({bool clearAll = false}) {
    debugPrint(clearAll.toString());
    if (clearAll == true) {
      displayValue = '0';
    } else {
      if ((!displayValue.startsWith('-') && displayValue.length > 1) ||
          (displayValue.startsWith('-') && displayValue.length > 2)) {
        displayValue = displayValue.substring(0, displayValue.length - 1);
      } else {
        displayValue = '0';
      }
    }
  }

  void setOperation(String operation) {
    switch (operation) {
      case '+':
        break;
      case '-':
        break;
      case '*':
        break;
      case '/':
        break;
      case '%':
        displayValue = (double.parse(displayValue) / 100).toString();
        break;
    }
  }

  setResult() {}

  parseDouble(String numstring) {}
}

// bool isNumber(String value) {
//   var a = int.tryParse(value);
//   return a != null;
// }
