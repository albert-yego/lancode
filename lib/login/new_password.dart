import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lancode/login/login.dart';
import 'package:lancode/util/constants.dart';
import 'package:lancode/components/default_button.dart';
import 'package:lancode/components/custom_snackbar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class emailChangePage extends StatefulWidget {
  const emailChangePage(
      {Key? key, required this.userEmail ,required this.userK})
      : super(key: key);

  final String userK;
  final String userEmail;

  State<emailChangePage> createState() => _emailChangePageState();
}

class _emailChangePageState extends State<emailChangePage> {
  final newPasswordController = TextEditingController();
  final passwordFocus = FocusNode();
  final _validationKey = GlobalKey<FormState>();


  late DatabaseReference dbref;
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child('Users').child(widget.userK);
  }

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth / 20, vertical: getHeight / 40),
        child: Container(
          key: _validationKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: getHeight / 100,
              ),
              Icon(
                Icons.lock,
                size: 50,
                color: Colors.purple,
              ),
              SizedBox(
                height: getHeight / 1500,
              ),
              Text(
                'New Password',
                style: GoogleFonts.bebasNeue(
                  color: Colors.grey[700],
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: getHeight / 50,
              ),
              buildNewPasswordFormField(),
              SizedBox(height: getHeight / 40),
              defaultButton(
                text:  'Change Password',
                onPress: () async {
                  if(newPasswordController.text.length==0){
                    passwordFocus.requestFocus();
                  }else{
                    try{
                      await auth.sendPasswordResetEmail(email: widget.userEmail);
                      dbref.update({'password': newPasswordController.text});
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => loginPage(),
                        ));
                    }on FirebaseAuthException catch(e){
                      if(e.code=='auth/invalid-email'){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: CustomSnackBarContent(
                              errorMessage:
                                  "Invalid email."),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ));
                      }
                      if(e.code=='auth/user-not-found'){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: CustomSnackBarContent(
                              errorMessage:
                                  "User doesn't exist."),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ));
                      }
                    }catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: CustomSnackBarContent(
                            errorMessage:
                                "Email is being used."),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ));
                    }
                    
                  }
                },
              ),
            ]
          )
        ),
      )
    );
  }

  TextFormField buildNewPasswordFormField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: newPasswordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      showCursor: true,
      cursorColor: Colors.purple,
      validator: (value) {
        if(value!.isEmpty){
          return 'Please enter password';
        }else{
          return null;
        }
      },
      focusNode: passwordFocus,
      autofocus: false,
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
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red)
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red)
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[500]),
        icon: Icon(
          Icons.lock,
          color: Colors.purple,
        ),
      ),
    );
  }
}
