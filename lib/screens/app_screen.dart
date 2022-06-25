import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

import '../models/data.dart';
import '../widgets/new_container.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? colorDark : colorLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        darkMode ? darkMode = false : darkMode = true;
                        HapticFeedback.selectionClick();
                      });
                    },
                    child: _switchMode(),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: GoogleFonts.montserrat(
                        fontSize: 55,
                        color: darkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '=',
                        style: GoogleFonts.montserrat(
                          fontSize: 35,
                          color: darkMode ? Colors.green : Colors.grey,
                        ),
                      ),
                      Text(
                        userQuestion,
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: darkMode ? Colors.green : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10)
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ovalButton(
                        title: 'sin',
                      ),
                      _ovalButton(title: 'cos'),
                      _ovalButton(title: 'tan'),
                      _ovalButton(title: '%'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _roundedButton(
                        title: 'C',
                        textColor: darkMode ? Colors.green : Colors.redAccent,
                      ),
                      _roundedButton(title: '('),
                      _roundedButton(title: ')'),
                      _roundedButton(
                        title: '/',
                        textColor: darkMode ? Colors.green : Colors.redAccent,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _roundedButton(title: '7'),
                      _roundedButton(title: '8'),
                      _roundedButton(title: '9'),
                      _roundedButton(
                        title: 'x',
                        textColor: darkMode ? Colors.green : Colors.redAccent,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _roundedButton(title: '4'),
                      _roundedButton(title: '5'),
                      _roundedButton(title: '6'),
                      _roundedButton(
                        title: '-',
                        textColor: darkMode ? Colors.green : Colors.redAccent,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _roundedButton(title: '1'),
                      _roundedButton(title: '2'),
                      _roundedButton(title: '3'),
                      _roundedButton(
                        title: '+',
                        textColor: darkMode ? Colors.green : Colors.redAccent,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _roundedButton(title: '0'),
                      _roundedButton(title: '.'),
                      _roundedButton(
                        title: 'back',
                        iconColor: darkMode ? Colors.green : Colors.redAccent,
                      ),
                      _roundedButton(
                        title: '=',
                        textColor: darkMode ? Colors.green : Colors.redAccent,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roundedButton({
    required String title,
    double padding = 16,
    final Color? iconColor,
    final Color? textColor,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (userQuestion == '' &&
              userAnswer != '' &&
              (title == '+' || title == '-' || title == 'x' || title == '/')) {
            userQuestion += (userAnswer + title);
          } else if (title == 'back') {
            userQuestion =
                userQuestion.substring(0, max(0, userQuestion.length - 1));
          } else if (title == 'C') {
            userQuestion = '';
            userAnswer = '';
          } else if (title == '=') {
            equalPressed();
          } else {
            userQuestion += title;
          }
          HapticFeedback.heavyImpact();
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: NewContainer(
          darkMode: darkMode,
          borderRadius: BorderRadius.circular(40),
          padding: EdgeInsets.all(padding),
          child: SizedBox(
            width: padding * 2,
            height: padding * 2,
            child: Center(
              child: title != 'back'
                  ? Text(
                      title,
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        color: textColor ??
                            (darkMode ? Colors.white : Colors.black),
                      ),
                    )
                  : Icon(
                      Icons.backspace_outlined,
                      color: iconColor,
                      size: 30,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ovalButton({
    required String title,
    double padding = 17,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          userQuestion += title;
          HapticFeedback.heavyImpact();
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: NewContainer(
          darkMode: darkMode,
          borderRadius: BorderRadius.circular(50),
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: padding / 2,
          ),
          child: SizedBox(
            width: padding * 2,
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: darkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _switchMode() {
    return NewContainer(
      darkMode: darkMode,
      borderRadius: BorderRadius.circular(40),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: SizedBox(
        width: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.wb_sunny,
              color: darkMode ? Colors.grey : Colors.redAccent,
            ),
            Icon(
              Icons.nightlight_round,
              color: darkMode ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void equalPressed() {
    userQuestion = userQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(userQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
    if (userAnswer.length > 9) {
      userAnswer = userAnswer.substring(0, 9);
    }
    userQuestion = '';
  }
}
