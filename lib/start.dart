import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lancode/question_page.dart';

import 'Questions.dart';
import 'main.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          backgroundColor: Colors.grey[300],
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(right: 170),
                child:

                ElevatedButton(

                  onPressed: MyTest.levelpassed >= 1 ? () {
                    MyTest.reset();
                    MyTest.level=1;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Question_Page()),
                    );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple, shape: CircleBorder(),),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Container(
                            height: 50,
                            child: Image.asset(
                                "assets/img/2055753.png")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Text(
                          "Level 1",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),),
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: ElevatedButton(
                onPressed: MyTest.levelpassed  >= 2 ? () {
                  MyTest.reset();
                  MyTest.level=2;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Question_Page()),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, shape: CircleBorder(),),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Container(
                          height: 50,
                          child: Image.asset(
                              "assets/img/1857147.png")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Text(
                        "Level 2",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 220),
              child: ElevatedButton(
                onPressed: MyTest.levelpassed  >= 3 ? () {
                  MyTest.reset();
                  MyTest.level=3;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Question_Page()),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, shape: CircleBorder(),),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Container(
                          height: 50,
                          child: Image.asset(
                              "assets/img/562626.png")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Text(
                        "Level 3",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: ElevatedButton(

                onPressed: MyTest.levelpassed  >= 4 ? () {
                  MyTest.reset();
                  MyTest.level=4;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Question_Page()),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, shape: CircleBorder(),),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Container(
                          height: 50,
                          child: Image.asset(
                              "assets/img/13845.png")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Text(
                        "Level 4",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 170),
              child: ElevatedButton(

                 onPressed: MyTest.levelpassed  >= 5 ? () {
                  MyTest.level=5;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Question_Page()),
                  );
                }
                : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, shape: CircleBorder(),),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Container(
                          height: 50,
                          child: Image.asset(
                              "assets/img/software-icon-13.png")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Text(
                        "Level 5",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
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

Widget levelButton({
  required String text,
  required String photoUrl,
  required double panding,
}) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.purple, shape: CircleBorder(),),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Container(height: 50, child: Image.asset(photoUrl)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
        ),
      ],
    ),
  );
}
