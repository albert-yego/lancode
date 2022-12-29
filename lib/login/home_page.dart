import 'package:lanquiz/components/default_button.dart';
import 'package:lanquiz/components/default_textfield.dart';
import 'package:lanquiz/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: getHeight/50),

              const Icon(
                Icons.lock,
                size: 100,
              ),

              SizedBox(height: getHeight/25),

              Text(
                'LANQUIZ',
                style: GoogleFonts.bebasNeue(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              SizedBox(height: getHeight/25),

              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              SizedBox(height: getHeight/25),

              defaultTextfield(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              SizedBox(height: getHeight/10),

              defaultTextfield(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              SizedBox(height: getHeight/10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              SizedBox(height: getHeight/50),

              defaultButton(
                onPress: () {
                  signUserIn();
                },
                text: 'Sign In',
              ),

              SizedBox(height: getHeight/50),

              SizedBox(height: getHeight/50),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
