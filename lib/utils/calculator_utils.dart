getStyle(String value) {
  if (double.tryParse(value) != null || value == '.') {
  } else {
    switch (value) {
      case '+':
      case '-':
      case '*':
      case '/':
      case '%':
        break;

      case '=':
        break;

      case '+/-':
        break;

      case 'c':
        break;

      case 'del':
        break;

      default:
        break;
    }
  }
}
