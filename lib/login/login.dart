import 'package:lanquiz/components/default_button.dart';
import 'package:lanquiz/components/default_textfield.dart';
import 'package:lanquiz/register/register.dart';
import 'package:lanquiz/util/constants.dart';
import 'package:lanquiz/home/splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';


class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool passwordVisibility = false;
  bool emailVisibility= true;
  String hinttext = 'Colors.purple';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => loginPage(),
              )
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          )
        ),
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 100,
              ),

              SizedBox(height: getHeight/35),

              Text(
                'LANQUIZ',
                style: GoogleFonts.bebasNeue(
                  color: Colors.grey[700],
                  fontSize: 50,
                ),
              ),

              SizedBox(height: getHeight/50),
              Container(
                width: 350,
                child: emailField(),
              ),
              Focus(
                child: Container(
                  width: 350,
                  child: passwordField(),
                ), 
                onFocusChange: (hasFocus){
                  if(hasFocus){
                    hinttext='Colors.white';
                  }
                },
              ),
              SizedBox(height: getHeight/25),

              defaultButton(
                onPress: () {
                  if(emailVisibility){
                    passwordVisibility=true;
                    emailVisibility=false;
                    setState(() {});
                  }else{
                    signUserIn();
                  }
                },
                text: (emailVisibility?'Continue':'Sign in'),
              ),

              SizedBox(height: getHeight/50),
              SizedBox(height: getHeight/50),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: getHeight/50),
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => registerPage(),
                          ));
                    },
                    child: Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  
  void signUserIn() {
    auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SplashScreenHAnimated()
      )
    ).then((value) => null);
    Fluttertoast.showToast(
      msg: "You are registered successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.purple,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  Visibility emailField(){
    return Visibility(
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: emailController,
        showCursor: true,
        decoration: InputDecoration(
          prefix: Padding(
            padding: EdgeInsets.all(4),
          ),
          labelText: "Email",
          floatingLabelStyle: TextStyle(color: Colors.purple),
          labelStyle: TextStyle(color: Colors.grey[500]),
          hintText: "Enter your email",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[500]),
          suffixIcon: Icon(
            Icons.email,
            color: Colors.purple,
          ),
        ),
      ),
      visible: emailVisibility,
    );
  }
  
  Visibility passwordField(){
    return Visibility(
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: passwordController,
        showCursor: true,
        decoration: InputDecoration(
          prefix: Padding(
            padding: EdgeInsets.all(4),
          ),
          labelText: "Password",
          floatingLabelStyle: TextStyle(color: Colors.purple),
          labelStyle: TextStyle(color: Colors.grey[500]),
          hintText: "Enter your password",
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[500]),
          suffixIcon: Icon(
            Icons.account_circle,
            color: Colors.purple,
          ),
        ),
      ),
      visible: passwordVisibility,
    );
  }
}
