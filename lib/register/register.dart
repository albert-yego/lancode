import 'package:flutter/material.dart';
import 'package:lancode/login/login.dart';
import 'package:lancode/util/constants.dart';
import 'package:lancode/register/register_form.dart';
import 'package:google_fonts/google_fonts.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
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
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth / 25),
            child: Column(
              children: [
                SizedBox(
                  height: getHeight / 30,
                ),
                Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.purple,
                ),
                SizedBox(
                  height: getHeight / 1500,
                ),
                Text(
                  'Registration',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.grey[700],
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: getHeight / 50,
                ),
                registerForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}