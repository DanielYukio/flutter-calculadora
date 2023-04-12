import 'package:flutter/material.dart';
import 'CalculatorUtils.dart';

class CalculatorState extends StatefulWidget {
  const CalculatorState({super.key});

  @override
  State<CalculatorState> createState() => _CalculatorState();
}

class _CalculatorState extends State<CalculatorState> {
  var calculator = Calculator();

  final buttons = [
    ['c', 'del', '%', '/'],
    ['7', '8', '9', '*'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['+/-', '0', '.', '='],
  ];

  _setValue(String value) {
    setState(() {
      calculator.setValue(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  hintText: calculator.displayValue,
                  border: const OutlineInputBorder(),
                ),
                readOnly: true,
                focusNode: primaryFocus,
              ),
              const SizedBox(height: 16),
              ...buttons.map(
                (e) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: e
                          .map(
                            (e) => ElevatedButton(
                              autofocus: false,
                              onPressed: () {
                                _setValue(e);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.20,
                                    MediaQuery.of(context).size.height * 0.06,
                                  )),
                              child: Text(
                                e.toUpperCase(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 16)
                  ].toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
