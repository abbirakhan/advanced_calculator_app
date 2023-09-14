import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => CalculatorAppState();
}

class CalculatorAppState extends State<CalculatorApp> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;
  onButtonClick(value) {
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '<') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
      //input = input.substring(0, input.length - 1);
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('x', '*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
        // output = output.substring(0, output.length - 2);
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  const Color.fromARGB(255, 208, 13, 94),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(
                        hideInput ? "" : input,
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        output,
                        style: TextStyle(
                          fontSize: outputSize,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(
                        height: 20, //40
                      ),
                    ],
                  ),
                ),
              ),
              //button area
              Row(
                children: [
                  button(
                    text: 'ESC',
                    buttenBgColor:  const Color(0xffFFFFFF),
                    textColor:  const Color.fromARGB(255, 208, 13, 94),
                  ),
                  button(
                    text: 'AC',
                    buttenBgColor:  const Color(0xffFFFFFF),
                    textColor:  const Color.fromARGB(255, 208, 13, 94),
                  ),
                  button(
                    text: '/',
                    buttenBgColor:  const Color(0xffFFFFFF),
                    textColor:  const Color.fromARGB(255, 208, 13, 94),
                  )
                ],
              ),
              Row(
                children: [
                  button(text: '7'),
                  button(text: '8'),
                  button(text: '9'),
                  button(
                    text: 'x',
                    buttenBgColor:  const Color(0xffFFFFFF),
                    textColor:  const Color.fromARGB(255, 208, 13, 94),
                  )
                ],
              ),
              Row(
                children: [
                  button(text: '4'),
                  button(text: '5'),
                  button(text: '6'),
                  button(
                    text: '-',
                    buttenBgColor: const Color(0xffFFFFFF),
                    textColor: const Color.fromARGB(255, 208, 13, 94),
                  )
                ],
              ),
              Row(
                children: [
                  button(text: '1'),
                  button(text: '2'),
                  button(text: '3'),
                  button(
                    text: '+',
                    buttenBgColor: Color(0xffFFFFFF),
                    textColor: Color.fromARGB(255, 208, 13, 94),
                  )
                ],
              ),
              Row(
                children: [
                  button(text: '%'),
                  button(text: '0'),
                  button(text: '.'),
                  button(
                      text: '=', buttenBgColor: Color.fromARGB(255, 57, 5, 54)),
                ],
              ),
            ],
          ),
        ));
  }

  Widget button({
    text,
    textColor,
    buttenBgColor = Colors.purple,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(22),
            backgroundColor: buttenBgColor,
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
