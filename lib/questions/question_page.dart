import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lancode/questions/result.dart';
import 'package:lancode/questions/start.dart';

import 'Questions.dart';

class Question_Page extends StatefulWidget {
  const Question_Page({Key? key}) : super(key: key);

  @override
  State<Question_Page> createState() => _Question_PageState();
}

class _Question_PageState extends State<Question_Page> {
  late Timer timer;
  int seconds = 2;
  int minutes=1;
  TextEditingController timeController = TextEditingController();


  void initState() {
    super.initState();
    startTimer();
  }
  void startTimer() {
    timer = Timer.periodic(Duration(seconds:1), (timer) {
      setState(() {
        seconds--;
        timeController.text = '$minutes $seconds';
      });
      if (seconds == 0) {
        if (minutes==0){
          timer.cancel();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Result()),
          );
        }else{
          setState(() {
            minutes--;
            timeController.text = '$minutes $seconds';
            seconds= 59;
          });
        }
      }
    });
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Start()),
              );},
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          title: Text(
          'QUESTIONS',
          style: GoogleFonts.bebasNeue(
            color: Colors.purple[700],
            fontSize: 30,
          ),
        ),

          backgroundColor: Colors.grey[300],
          elevation: 0,

        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("12 / ${(MyTest.count+1).toString()}",
                      style: TextStyle(

                        fontSize: 25.0,
                      ),)
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      seconds > 2
                          ? const Icon(Icons.timer_sharp,size: 45,)
                          : Icon(
                        Icons.timer_sharp,
                        size: 55,
                      ),
                      seconds > 2
                          ? Text('${minutes}:${seconds}',style: TextStyle(

                        fontSize: 25.0,
                      ))
                          : Text('${minutes}:${seconds}',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                      ),),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  MyTest.writeQuestion_text(),
                  style: (TextStyle(fontSize: 25)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15,right: 10 ,bottom: 25),
              child: Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text(
                      "a) ${MyTest.asikki()}",
                        style: (TextStyle(fontSize: 20)),
                      ),
                      Text(
                        "b) ${MyTest.bsikki()}",
                        style: (TextStyle(fontSize: 20)),
                      ),
                      Text(
                        "c) ${MyTest.csikki()}",
                        style: (TextStyle(fontSize: 20)),
                      ),
                      Text(
                        "d) ${MyTest.dsikki()}",
                        style: (TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                ),
            ),

            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: MaterialButton(
                          onPressed: () {
                            if (MyTest.count == 11) {
                              MyTest.checkQuestion("a");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Result()),
                              );
                            } else {
                              setState(() {
                                MyTest.checkQuestion("a");
                              });
                            }
                          },

                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Color(0xFF9C27B0), Color(0XFFF42A5F5)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(10.0),

                            ),
                            child: Container(
                              constraints: BoxConstraints(minWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "a",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: MaterialButton(
                          onPressed: () {
                            if (MyTest.count == 11) {
                              MyTest.checkQuestion("b");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Result()),
                              );
                            } else {
                              setState(() {
                                MyTest.checkQuestion("b");
                              });
                            }
                          },

                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Color(0xFF9C27B0), Color(0XFFF42A5F5)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(10.0),

                            ),
                            child: Container(
                              constraints: BoxConstraints(minWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "b",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: MaterialButton(
                          onPressed: () {
                            if (MyTest.count == 11) {
                              MyTest.checkQuestion("c");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Result()),
                              );
                            } else {
                              setState(() {
                                MyTest.checkQuestion("c");
                              });
                            }
                          },

                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Color(0xFF9C27B0), Color(0XFFF42A5F5)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(10.0),

                            ),
                            child: Container(
                              constraints: BoxConstraints(minWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                              "c",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: MaterialButton(
                          onPressed: () {
                            if (MyTest.count == 11) {
                              MyTest.checkQuestion("d");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Result()),
                              );
                            } else {
                              setState(() {
                                MyTest.checkQuestion("d");
                              });
                            }
                          },

                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [Color(0xFF9C27B0), Color(0XFFF42A5F5)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(10.0),

                            ),
                            child: Container(
                              constraints: BoxConstraints(minWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "d",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "result",
              style: TextStyle(fontSize: 20.0),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                children: MyTest.resultIcone,
              ),
            ),
            const SizedBox(
              height: 20.0,
            )
          ],
        ),
      );
  }
}
