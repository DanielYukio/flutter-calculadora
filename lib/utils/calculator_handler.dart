import 'package:flutter/material.dart';

class Operation {
  late double? n1 = null;
  late double? n2 = null;
  late String? op = null;

  Operation();

  clear() {
    n1 = n2 = op = null;
  }

  bool get isNotPrepared {
    return (n1 == null || n2 == null || op == null);
  }

  double? getResult() {
    if (isNotPrepared) {
      return null;
    }
    late final double? result;
    switch (op) {
      case '+':
        result = n1! + n2!;
        clear();
        break;

      case '-':
        result = n1! - n2!;
        clear();
        break;

      case 'x':
        result = n1! * n2!;
        clear();
        break;

      case '/':
        if (n2 == 0) {
          result = null;
        } else {
          result = n1! / n2!;
        }
        clear();
        break;

      default:
        result = null;
        clear();
        break;
    }
    return result;
  }
}

class Calculator {
  String displayValue = '0';
  Operation operation = Operation();
  bool waitingNewValue = true;

  bool get error {
    return displayValue == 'ERRO';
  }

  void setValue(String value) {
    debugPrint(
        '${operation.n1.toString()} ${operation.op.toString()} ${operation.n2.toString()}');
    if (error) {
      displayValue = '0';
      waitingNewValue = true;
    }
    if (double.tryParse(value) != null) {
      printNumber(value);
    } else {
      switch (value) {
        case '+':
        case '-':
        case 'x':
        case '/':
          setOperation(value);
          break;

        case '%':
          divideBy100();
          break;

        case '=':
          getResult();
          break;

        case '+/-':
          toggleSignal();
          break;

        case '.':
          addPoint();
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

  void printNumber(String value) {
    if (displayValue.length < 12) {
      if (displayValue == '0' || waitingNewValue) {
        displayValue = value;
      } else {
        displayValue += value;
      }
    } else {
      if (waitingNewValue) {
        displayValue = value;
      }
    }
    waitingNewValue = false;
  }

  void divideBy100() {
    if (double.parse(displayValue) != 0) {
      displayValue = (double.parse(displayValue) / 100).toString();
      if (displayValue.length >= 12) {
        displayValue = displayValue.substring(0, 12);
      }
    }
  }

  void addPoint() {
    if (displayValue.length < 13) {
      if (waitingNewValue) {
        displayValue = '0.';
      } else if (!displayValue.contains('.')) {
        displayValue += '.';
      }
    }
    waitingNewValue = false;
  }

  void toggleSignal() {
    if (displayValue.length < 13 || displayValue.startsWith('-')) {
      if (waitingNewValue) {
        displayValue = '0';
      }
      if (double.parse(displayValue) > 0) {
        displayValue = '-$displayValue';
      } else if (double.parse(displayValue) < 0) {
        displayValue = displayValue.substring(1);
      }
    } else {
      if (waitingNewValue) {
        displayValue = '0';
      }
    }
    waitingNewValue = false;
  }

  void delete({bool clearAll = false}) {
    if (clearAll == true) {
      displayValue = '0';
      operation.clear();
    } else {
      if ((!displayValue.startsWith('-') && displayValue.length > 1) ||
          (displayValue.startsWith('-') && displayValue.length > 2)) {
        displayValue = displayValue.substring(0, displayValue.length - 1);
        if (double.parse(displayValue) == 0 && displayValue.startsWith('-')) {
          displayValue = '0';
        }
      } else {
        displayValue = '0';
      }
    }
  }

  void setOperation(String op) {
    if (operation.n1 == null) {
      operation.n1 = double.parse(displayValue);
      operation.op = op;
      waitingNewValue = true;
    } else {
      operation.n2 = double.parse(displayValue);
      if (operation.op == null) {
        operation.op = op;
        waitingNewValue = true;
      } else {
        getResult();
        operation.n1 = double.parse(displayValue);
        operation.op = op;
      }
    }
  }

  getResult() {
    operation.n2 ??= double.parse(displayValue);
    if (operation.isNotPrepared || waitingNewValue) {
      operation.n2 = null;
      return;
    }
    final double? result = operation.getResult();
    displayValue = result == null ? 'ERRO' : result.toString();
    if (result != null && result - result.toInt() == 0) {
      displayValue = displayValue.substring(0, displayValue.indexOf('.'));
    }
    if (displayValue.length >= 12) {
      displayValue = displayValue.substring(0, 13);
    }
    waitingNewValue = true;
  }
}
