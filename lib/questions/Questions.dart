import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lancode/questions/result.dart';

import 'soru_yapısı.dart';

Test MyTest = new Test();

class Test {
  //nitelikler ve özellikler
  int seconds = 2;
  int minutes=1;
  int showQuestion = 0;
  var count = 0;
  var t_rue = 0;
  var level = 1;
  var levelpassed = 1;
  List<Icon> resultIcone = [];
  List<Question> Questions = [
    Question(question_text: "What is a correct syntax to output 'Hello World' in Python?",
        a: "echo('Hello World');  ", b: "echo 'Hello World'", c: "p('Hello World')", d: "print('Hello World') ", answer: "d"),
    Question(question_text: "How do you insert COMMENTS in Python code?",
        a: "#This is a comment  ", b: "/*This is a comment*/", c: "//This is a comment", d: "/This is a comment", answer: "a"),
    Question(question_text: "Which one is NOT a legal variable name?",
        a: "my_var", b: "_myvar", c: "Myvar", d: "my-var  ", answer: "d"),
    Question(question_text: "What is the correct file extension for Python files?",
        a: ".pt  ", b: ".pyt", c: ".pyth", d: ".py  ", answer: "d"),
    Question(question_text: "What is the correct syntax to output the type of a variable or object in Python?",
        a: "print(typeof(x)) ", b: "print(typeOf(x))", c: "print(typeof x)", d: "print(type(x))  ", answer: "d"),
    Question(question_text: "Which method can be used to remove any whitespace from both the beginning and the end of a string?",
        a: "strip()  ", b: "len()", c: "ptrim()", d: "trim()", answer: "a"),
    Question(question_text: "Which method can be used to return a string in upper case letters?",
        a: "upperCase()  ", b: "toUpperCase()", c: "uppercase()", d: "upper()  ", answer: "d"),
    Question(question_text: "Which method can be used to replace parts of a string?",
        a: "replace()", b: "replaceString()", c: "repl()", d: "switch()", answer: "a"),
    Question(question_text: "Which operator is used to multiply numbers?",
        a: "%  ", b: "#", c: "* ", d: "x", answer: "c"),
    Question(question_text: "Which operator can be used to compare two values?",
        a: "<>  ", b: "=", c: "==  ", d: "><", answer: "c"),
    Question(question_text: "Which collection is ordered, changeable, and allows duplicate members?",
        a: "TUPLE  ", b: "DICTIONARY", c: "SET", d: "LIST  ", answer: "d"),
    Question(question_text: "How do you start writing a while loop in Python?",
        a: "while x > y:  ", b: "while x > y {", c: "x > y while {", d: "while (x > y)", answer: "a"),
  ];
  List<Question> Questions1 = [
    Question(question_text: "What is the result of print(type([]) is list)?",
        a: " False", b: "True", c: "list", d: "type", answer: "b"),
    Question(question_text: "What is the data type of print(type(10))",
        a: "float", b: "integer", c: "double", d: "int", answer: "d"),
    Question(question_text: "What is the data type of print(type(0xFF))",
        a: "number", b: "hexint", c: "hex", d: "int", answer: "d"),
    Question(question_text: "What is the output of the following code /n print(bool(0), bool(3.14159), bool(-3), bool(1.0+1j))",
        a: "False True False True", b: "False True False True", c: "False True False True",
        d: "False True True True", answer: "d"),
    Question(question_text: "In Python 3, what is the output of type(range(5)). (What data type it will return).",
        a: "int", b: "int",
        c: "range", d: "None", answer: "d"),
    Question(question_text: "What is the output of print(2 ** 3 ** 2)",
        a: " 64", b: " 512", c: "157", d: "517", answer: "b"),
    Question(question_text: "Bitwise shift operators (<<, >>) has higher precedence than Bitwise And(&) operator",
        a: "False", b: "True", c: " path",
        d: " libraries", answer: "b"),
    Question(question_text: "What is the output of print(2 * 3 ** 3 * 4)", a: "216",
        b: "206", c: "864", d: "none", answer: "a"),
    Question(question_text: "Which of the following operators has the highest precedence?",
        a: "not", b: "&", c: "*", d: "+", answer: "c"),
    Question(question_text: "What is the output of the expression  print(-18 // 4)",
        a: " -4", b: "4", c: " -5", d: " 5", answer: "c"),
    Question(question_text: "What is the output of print(2%6)",
        a: "ValueError", b: " 0.33", c: "2", d: "1.6", answer: "c"),
    Question(question_text: "Select which is true for Python function",
        a: "A Python function can return only a single value",
        b: " A function can take an unlimited number of arguments.",
        c: "A Python function can return multiple values", d: "Python function doesn’t return anything unless and until you add a return statement",
        answer: "b"),

  ];
  List<Question> Questions2 = [
    Question(question_text: "Select which true for Python function",
        a: "A function is a code block that only executes when called and always returns a value.",
        b: "Python doesn’t support nested function",
        c: "A function executes when it is called and we can reuse it in a program",
        d: "none ",
        answer: "a"),
    Question(question_text: "Select which is true for for loop",
        a: "Python’s for loop used to iterates over the items of list, tuple, dictionary, set, or string  ",
        b: "else clause of for loop is executed when the loop terminates abruptly",
        c: "We use for loop when we want to perform a task indefinitely until a particular condition is met", d:
        "all",
        answer: "a"),
    Question(question_text: "What is the output of print(abs(-45.300))",
        a: "45.3", b: "-45.3", c: "-45.300", d: "45.300 ", answer: "a"),
    Question(question_text: "What is the type of the following variable x = -5j",
        a: "int  ", b: "complex", c: "real", d: "imaginary  ", answer: "b"),
    Question(question_text: "What is the output of the following code print(int(2.999))",
        a: "ValueError: invalid literal for int() ", b: "3", c: "2", d: "-2  ", answer: "c"),
    Question(question_text: "Which statement is used to stop a loop?",
        a: "exit  ", b: "stop", c: "void", d: "break    ", answer: "d"),
    Question(question_text: "What is the output for −'Tutorials Point' [100:200]?",
        a: "Index error.  ", b: "' '", c: " 'Tutorials Point'", d: "Syntax error  ", answer: "b"),
    Question(question_text: "How can we swap two numbers a = 10, b = 20 in python without using third variable?",
        a: "a = b b = a", b: " a,b = b,a", c: "both a & b", d: "b = a", answer: "c"),
    Question(question_text: "What is the output of the following code? eval(''1 + 3 * 2'')",
        a: " ‘1+6’", b: " ‘4*2’", c: "‘1+3*2’ ", d: " 7", answer: "d"),
    Question(question_text: "Which options are correct to create an empty set in Python?",
        a: "{}  ", b: " ()", c: " [] ", d: "set()", answer: "d"),
    Question(question_text: "Select the correct code to create a check button under parent frame1 and it should be bind to v1?",
        a: "CheckButton(frame1, text=''Bold'' , command=CheckButton)  ",
        b: "Checkbutton(frame1 , text=''Bold’’ ,variable=v1 ,command=processCheckbutton)",
        c: "Checkbutton(frame1,text=''Bold'',variable=v1.set(),command=v1.set(processCheckbut ton)",
        d: " Checkbutton(frame.set(f1) ,text.set(''bold'') ,command=v1.set(processCheckbutton)  ",
        answer: "b"),
    Question(question_text: " Which way among them is used to create an event loop ?",
        a: " Window.eventloop()  ", b: "Window.mainloop()", c: "Window.loop()", d: " Eventloop.window()",
        answer: "b"),

  ];
  List<Question> Questions3 = [
    Question(question_text: "Which can be an Identifier among them in Python?",
        a: " 1abc", b: "12a  ", c: "_xy1", d: "@python", answer: "c"),
    Question(question_text: "What is a folder?",
        a: "the name given to a set of recorded information  ",
        b: "the name given to a set of recorded information",
        c: "the name given to the place where files that can be stolen",
        d: "the name given to the place where files that can be stored",
        answer: "d"),
    Question(question_text: "Which of the following types of computer languages uses binary code to communicate with the computer?",
        a: "High-level languages",
        b: "Assembly languages", c: "Machine language",
        d: "Database languages", answer: "c"),
    Question(question_text: "What is the process of developing and implementing various sets of instructions to enable a computer to do a certain task?",
        a: "Computer Engineering", b: "Computer Programming", c: "Computer Processing",
        d: "Computer Science", answer: "b"),
    Question(question_text: " Who developed Python Programming Language?",
        a: "Wick van Rossum", b: "Rasmus Lerdorf", c: "Guido van Rossum",
        d: " Niene Stom", answer: "c"),
    Question(question_text: "Which type of Programming does Python support?",
        a: "object-oriented programming",
        b: "structured programming",
        c: "functional programming", d: "all of the mentioned", answer: "d"),
    Question(question_text: "Is Python case sensitive when dealing with identifiers?",
        a: " no", b: "yes", c: "machine dependent", d: "none of the mentioned", answer: "b"),
    Question(question_text: " Is Python code compiled or interpreted?",
        a: "Python code is both compiled and interpreted", b: "Python code is neither compiled nor interpreted",
        c: "Python code is only compiled  ", d: "Python code is only interpreted", answer: "a"),
    Question(question_text: "All keywords in Python are in _________",
        a: "Capitalized  ", b: "lower case", c: "UPPER CASE", d: " None of the mentioned", answer: "d"),
    Question(question_text: "Which of the following is used to define a block of code in Python language?",
        a: "Indentation", b: "Key", c: "Brackets", d: "All of the mentioned", answer: "a"),
    Question(question_text: "Which keyword is used for function in Python language?",
        a: "Function", b: "def", c: "Fun", d: "Define", answer: "b"),
    Question(question_text: "Which of the following functions can help us to find the version of python that we are currently working on?",
        a: " sys.version(1)", b: "sys.version(0)", c: " sys.version()", d: "sys.version", answer: "d"),
  ];
  List<Question> Questions4 = [
    Question(question_text: "Python supports the creation of anonymous functions at runtime, using a construct called __________",
        a: "pi",
        b: " anonymous", c: "lambda",
        d: "none of the mentioned  ", answer: "c"),
    Question(question_text: " What is the order of precedence in python?",
        a: "Exponential, Parentheses, Multiplication, Division, Addition, Subtraction  ",
        b: "Exponential, Parentheses, Division, Multiplication, Addition, Subtraction",
        c: "Parentheses, Exponential, Multiplication, Division, Subtraction, Addition",
        d: "Parentheses, Exponential, Multiplication, Division, Addition, Subtraction", answer: "d"),
    Question(question_text: " What will be the output of the following Python code snippet if x=1?  x<<2",
        a: "4", b: " 2", c: "1", d: "8  ", answer: "a"),
    Question(question_text: "What does pip stand for python?",
        a: "Pip Installs Python", b: "Pip Installs Packages",
        c: "Preferred Installer Program",
        d: " All of the mentioned", answer: "c"),
    Question(question_text: "Which of the following is true for variable names in Python?",
        a: "underscore and ampersand are the only two special characters allowed",
        b: "unlimited length",
        c: "all private members must have leading and trailing underscores ",
        d: "none of the mentioned", answer: "b"),
    Question(question_text: "Which of the following functions is a built-in function in python?",
        a: "factorial()", b: "print() ", c: "seed()", d: "sqrt()", answer: "b"),
    Question(question_text: "Which of the following is the use of id() function in python?",
        a: "Every object doesn’t have a unique id",
        b: "Id returns the identity of the object ",
        c: "All of the mentioned", d: "None of the mentioned", answer: "b"),
    Question(question_text: "Which of the following is not a core data type in Python programming?",
        a: "Tuples", b: "Lists", c: "Class"  , d: "Dictionary", answer: "c"),
    Question(question_text: " Which of these is the definition for packages in Python?",
        a: "A set of main modules ", b: "A folder of python modules", c: "A number of files containing Python definitions and statements",
        d: "A set of programs making use of Python modules", answer: "b"),
    Question(question_text: " The process of pickling in Python includes ____________",
        a: "conversion of a Python object hierarchy into byte stream",
        b: "conversion of a datatable into a list",
        c: " conversion of a byte stream into Python object hierarchy  ",
        d: "conversion of a list into a datatable",
        answer: "a"),
    Question(question_text: "Which of the following is the use of id() function in python?",
        a: "Every object in Python doesn’t have a unique id",
        b: "In Python Id function returns the identity of the object",
        c: "None of the mentioned",
        d: "All of the mentioned  ",
        answer: "b"),
    Question(question_text: "What is output of print(math.pow(3, 2))?",
        a: "9.0", b: "None", c: "9", d: "None of the mentioned  ", answer: "a"),

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
        Icon(Icons.check_circle,
        color: Colors.purple,),
      );
      t_rue++;
      print(t_rue);
    } else {
      print("wrong");
      resultIcone.add(
        Icon(Icons.cancel,
           color: Colors.red),
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
