import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:my_mate/Calculator/colors.dart';

class Calc_homeScreen extends StatefulWidget {
  @override
  State<Calc_homeScreen> createState() => _Calc_homeScreenState();
}

class _Calc_homeScreenState extends State<Calc_homeScreen> {
  double firstnum = 0.0;

  double secondnum = 0.0;

  var input = "";

  var output = "";

  var operation = "";

  var hideInput = false;

  var outputSize = 30.0;

  onButtonClick(value) {
    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "C") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('×', '*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 40;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 30;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, actions: [
        Row(children: [
          const Text(
            'Calculator',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            width: 190,
          ),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                            'How to use:\n\n1. Just use it as a normal calculator.\n\n'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'))
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.info_outline, color: Colors.white))
        ])
      ]),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hideInput ? "" : input,
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  output,
                  style: TextStyle(fontSize: outputSize, color: Colors.grey),
                ),
                const SizedBox(height: 30)
              ],
            ),
          )),
          Row(
            children: [
              Button(
                  text: "AC",
                  buttonbgColor: operatorColor,
                  tcolor: orangeColor),
              Button(
                  text: "C", buttonbgColor: operatorColor, tcolor: orangeColor),
              Button(
                  text: "%", buttonbgColor: operatorColor, tcolor: orangeColor),
              Button(
                  text: "/", buttonbgColor: operatorColor, tcolor: orangeColor)
            ],
          ),
          Row(
            children: [
              Button(text: "7"),
              Button(text: "8"),
              Button(text: "9"),
              Button(
                  text: "×", buttonbgColor: operatorColor, tcolor: orangeColor)
            ],
          ),
          Row(
            children: [
              Button(text: "4"),
              Button(text: "5"),
              Button(text: "6"),
              Button(
                  text: "-", buttonbgColor: operatorColor, tcolor: orangeColor)
            ],
          ),
          Row(
            children: [
              Button(text: "1"),
              Button(text: "2"),
              Button(text: "3"),
              Button(
                  text: "+", buttonbgColor: operatorColor, tcolor: orangeColor)
            ],
          ),
          Row(
            children: [
              Button(text: "00"),
              Button(text: "0"),
              Button(text: "."),
              Button(text: "=", buttonbgColor: orangeColor)
            ],
          ),
        ],
      ),
    );
  }

  Widget Button({text, tcolor = Colors.white, buttonbgColor = buttonColor}) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(22),
              backgroundColor: buttonbgColor),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: tcolor),
          )),
    ));
  }
}
