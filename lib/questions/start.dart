import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lancode/home/home.dart';
import 'package:lancode/questions/question_page.dart';

import 'Questions.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => homePage()),
              );},
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          backgroundColor: Colors.grey[300],
          elevation: 0,
          title: Text(
          'PYTHON',
          style: GoogleFonts.bebasNeue(
            color: Colors.purple[700],
            fontSize: 30,
          ),
        ),
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
                                "assets/img/l1.png")),
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
                              "assets/img/l2.png")),
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
                              "assets/img/l3.png")),
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
                              "assets/img/l4.png")),
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
                              "assets/img/l5.png")),
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
