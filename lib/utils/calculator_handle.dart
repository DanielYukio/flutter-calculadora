
class Operation {
  late double? n1;
  late double? n2;
  late String? op;

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

      case '*':
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
    if (error) {
      displayValue = '0';
      waitingNewValue = true;
    }
    if (double.tryParse(value) != null) {
      setNumber(value);
    } else {
      switch (value) {
        case '+':
        case '-':
        case '*':
        case '/':
          setOperation(value);
          break;

        case '%':
          displayValue = (double.parse(displayValue) / 100).toString();
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

  void setNumber(String value) {
    if (displayValue == '0' || waitingNewValue) {
      displayValue = value;
    } else {
      displayValue += value;
    }
    waitingNewValue = false;
  }

  void addPoint() {
    if (!displayValue.contains('.')) {
      displayValue += '.';
    }
    waitingNewValue = false;
  }

  void toggleSignal() {
    if (double.parse(displayValue) > 0) {
      displayValue = '-$displayValue';
    } else if (double.parse(displayValue) < 0) {
      displayValue = displayValue.substring(1);
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
    waitingNewValue = true;
  }
}
