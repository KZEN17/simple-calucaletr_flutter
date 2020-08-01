import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator for Lenka',
      theme: ThemeData(primaryColor: Colors.indigo),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  Color primaryColor = Colors.white;
  Color secondaryColor = Color.fromARGB(255, 16, 76, 145);
  Color tertiaryColor = Color.fromARGB(255, 31, 138, 192);
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 58.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 58.0;
      } else if (buttonText == "⟸") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 58.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      color: buttonColor,
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      child: FlatButton(
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.w300),
        ),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(0.0),
        //   side: BorderSide(
        //       color: Colors.white, width: 0.5, style: BorderStyle.solid),
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          Container(
            color: Colors.white,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: equationFontSize,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            color: Colors.white,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: resultFontSize,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
            ),
          ),
          // Expanded(
          //     child: Container(
          //   color: Colors.white,
          // )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('⟸', 1, Colors.white),
                        buildButton('×', 1, Colors.white),
                        buildButton('÷', 1, Colors.white),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('7', 1, primaryColor),
                        buildButton('8', 1, primaryColor),
                        buildButton('9', 1, primaryColor),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('4', 1, primaryColor),
                        buildButton('5', 1, primaryColor),
                        buildButton('6', 1, primaryColor),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('1', 1, primaryColor),
                        buildButton('2', 1, primaryColor),
                        buildButton('3', 1, primaryColor),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('.', 1, primaryColor),
                        buildButton('0', 1, primaryColor),
                        buildButton('00', 1, primaryColor),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('C', 1, Colors.greenAccent[100]),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('-', 1, Colors.white),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('+', 1.5, Colors.white),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('=', 1.5, Colors.pink[200]),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
