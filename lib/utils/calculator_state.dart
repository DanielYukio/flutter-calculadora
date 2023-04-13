import 'package:flutter/material.dart';
import 'package:flutter_calculadora/utils/calculator_utils.dart';
import 'calculator_handler.dart';

class CalculatorState extends StatefulWidget {
  const CalculatorState({super.key});

  @override
  State<CalculatorState> createState() => _CalculatorState();
}

class _CalculatorState extends State<CalculatorState> {
  var calculator = Calculator();

  final buttons = [
    ['c', 'del', '%', '/'],
    ['7', '8', '9', 'x'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['+/-', '0', '.', '='],
  ];

  _onPressed(String value) {
    setState(() {
      calculator.setValue(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(221, 20, 33, 52),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(),
              ),
              TextField(
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(right: 10),
                    hintText: calculator.displayValue,
                    hintStyle: const TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                    ),
                    border: InputBorder.none),
                readOnly: true,
              ),
              const SizedBox(height: 30),
              ...buttons.map(
                (e) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: e
                          .map(
                            (e) => TextButton(
                              autofocus: false,
                              onPressed: () {
                                _onPressed(e);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    CalculatorStyles.buttonBackgroundColor(e),
                                foregroundColor:
                                    CalculatorStyles.buttonForegroundColor(e),
                                shape: const CircleBorder(),
                                elevation: 10,
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.18,
                                  MediaQuery.of(context).size.width * 0.18,
                                ),
                              ),
                              child: Text(
                                e.toUpperCase(),
                                style: TextStyle(
                                  fontSize: CalculatorStyles.buttonTextSize(e),
                                  color: CalculatorStyles.buttonTextColor(e),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 10)
                  ].toList(),
                ),
              ),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}
