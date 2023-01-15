import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lancode/main.dart';
import 'package:lancode/questions/question_page.dart';
import 'package:lancode/questions/start.dart';


import 'Questions.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: null,
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 150),
              child: Expanded(

                child: Text("Lesson Evaluation",


                  textAlign:TextAlign.center,
              ),
            ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: Offset(5, 5),
                      )
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.purple,
                        Colors.blue,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Text(
                          "score",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                        Text(
                          ((MyTest.t_rue * 100) / 12).floor().toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 60.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: Expanded(
                child: ((MyTest.t_rue * 100) / 12) > 50
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  return states.contains(MaterialState.pressed)
                                      ? Colors.red
                                      : Colors.purple;
                                }),
                                minimumSize:
                                    MaterialStateProperty.resolveWith((states) {
                                  return states.contains(MaterialState.pressed)
                                      ? Size(200, 50)
                                      : Size(150, 50);
                                }),
                              ),
                              onPressed: () {
                                MyTest.showQuestion = 0;
                                MyTest.count = 0;
                                MyTest.t_rue = 0;
                                MyTest.resultIcone = [];

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Question_Page()),
                                );
                              },
                              child: Text("play again"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  return states.contains(MaterialState.pressed)
                                      ? Colors.red
                                      : Colors.blue;
                                }),
                                minimumSize:
                                    MaterialStateProperty.resolveWith((states) {
                                  return states.contains(MaterialState.pressed)
                                      ? Size(200, 50)
                                      : Size(150, 50);
                                }),
                              ),
                              onPressed: () {
                                MyTest.ispased();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Start()),

                                );
                              },
                              child: Text("go"),

                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  return states.contains(MaterialState.pressed)
                                      ? Colors.red
                                      : Colors.purple;
                                }),
                                minimumSize:
                                    MaterialStateProperty.resolveWith((states) {
                                  return states.contains(MaterialState.pressed)
                                      ? Size(200, 50)
                                      : Size(150, 50);
                                }),
                              ),
                              onPressed: () {
                                MyTest.showQuestion = 0;
                                MyTest.count = 0;
                                MyTest.t_rue = 0;
                                MyTest.resultIcone = [];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Question_Page()),
                                );
                              },
                              child: Text("play again"),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
