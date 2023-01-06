import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/result.dart';

import 'soru_yapısı.dart';

Test MyTest = new Test();

class Test {
  //nitelikler ve özellikler

  int showQuestion = 0;
  var count = 0;
  var t_rue = 0;
  var level = 1;
  var levelpassed = 1;
  List<Icon> resultIcone = [];
  List<Question> Questions = [
    Question(question_text: "2+2", a: "3", b: "4", c: "5", d: "6", answer: "b"),
    Question(
        question_text: "asc",
        a: "asc",
        b: "aca",
        c: "asc",
        d: "d",
        answer: "answer"),
    Question(question_text: "2+4", a: "3", b: "4", c: "5", d: "6", answer: "d"),
    Question(question_text: "5-2", a: "3", b: "4", c: "5", d: "6", answer: "a"),
    Question(question_text: "2-8", a: "3", b: "4", c: "5", d: "-6", answer: "d"),
    Question(
        question_text: "panama kanalı nerededir?",
        a: "asya",
        b: "avrupa",
        c: "amerika",
        d: "avusturalya",
        answer: "c"),
  ];
  List<Question> Questions1 = [
    Question(question_text: "2x5", a: "10", b: "14", c: "50", d: "6", answer: "a"),
    Question(question_text: "8x6", a: "36", b: "48", c: "52", d: "64", answer: "b"),
    Question(question_text: "96/8 ", a: "13", b: "14", c: "12", d: "6", answer: "c"),
    Question(question_text: "2. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
    Question(question_text: "2. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
  ];
  List<Question> Questions2 = [
    Question(question_text: "3. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
    Question(question_text: "3. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
    Question(question_text: "3. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
    Question(question_text: "3. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
    Question(question_text: "3. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
  ];
  List<Question> Questions3 = [
    Question(question_text: "4. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
    Question(question_text: "4. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
    Question(question_text: "4. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
    Question(question_text: "4. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
    Question(question_text: "4. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
  ];
  List<Question> Questions4 = [
    Question(question_text: "5. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
    Question(question_text: "5. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
    Question(question_text: "5. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
    Question(question_text: "5. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
    Question(question_text: "5. level soruları", a: "3", b: "4", c: "5", d: "6", answer: "b"),
  ];

//metod
  List levelQuestion(){
    switch(level) {
      case 1: {
        return Questions;
      }
      break;
      case 2: {
        return Questions1;
      }
      break;
      case 3: {
        return Questions2;
      }
      break;
      case 4: {
        return Questions3;
      }
      break;
      case 5: {
        return Questions4;
      }
      break;
      default: {
        level=1;
        return Questions;
      }
      break;
    }



  }

  // sonraki soru olacak

  void goNextQyestion() {
    if (levelQuestion().length - 1 > showQuestion) {
      showQuestion++;
    } else {
      showQuestion = 0;
    }
  }

// sotu metnini yaz
  String writeQuestion_text() {
    return levelQuestion()[showQuestion].Question_text;
  }

  String asikki() {
    return levelQuestion()[showQuestion].Option_a;
  }

  String bsikki() {
    return levelQuestion()[showQuestion].Option_b;
  }

  String csikki() {
    return levelQuestion()[showQuestion].Option_c;
  }

  String dsikki() {
    return levelQuestion()[showQuestion].Option_d;
  }


  void checkQuestion(String k_cevabi) {
    if (levelQuestion()[showQuestion].Answer == k_cevabi) {
      print("true");
      resultIcone.add(
        Icon(Icons.check),
      );
      t_rue++;
      print(t_rue);
    } else {
      print("wrong");
      resultIcone.add(
        Icon(Icons.close),
      );
    }
    if (count != 12) {
      goNextQyestion();
      count++;
    }
  }

  void ispased(){
    if(((MyTest.t_rue * 100) / 12) > 50){
      if(level==levelpassed){
        levelpassed =levelpassed+1;
        print(levelpassed);
      }

  }
  }
  void reset(){
    MyTest.showQuestion = 0;
    MyTest.count = 0;
    MyTest.t_rue = 0;
    MyTest.resultIcone = [];
  }
}

// Yapı
