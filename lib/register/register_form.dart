import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lancode/util/constants.dart';
import 'package:lancode/login/login.dart';
import 'package:lancode/components/default_textfield.dart';
import 'package:lancode/components/default_button.dart';
import 'package:lancode/components/custom_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';

class registerForm extends StatefulWidget {
  const registerForm({super.key});

  @override
  State<registerForm> createState() => _registerFormState();
}

class _registerFormState extends State<registerForm> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  final _validationKey = GlobalKey<FormState>();
  bool fieldCorrect = false;
  final nameFocus = FocusNode();
  final surnameFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneNumberFocus = FocusNode();
  final passwordFocus = FocusNode();

  final FirebaseAuth auth = FirebaseAuth.instance;

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Users');
  }

  void dispose() {
    Focus.of(context).unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: getHeight / 40),
              nameField(),
              SizedBox(height: getHeight / 40),
              surnameField(),
              SizedBox(height: getHeight / 40),
              emailField(),
              SizedBox(height: getHeight / 40),
              phoneNumberField(),
              SizedBox(height: getHeight / 40),
              passwordField(),
              SizedBox(height: getHeight / 20),
              defaultButton(
                text: 'Register',
                onPress: () async {
                   _validationKey.currentState?.validate();
                  if (nameController.text.length == 0) {
                    nameFocus.requestFocus();
                  } else if (surnameController.text.length == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: CustomSnackBarContent(
                            errorMessage:
                                "You didn't enter your surname"),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  } else if (phoneNumberController.text.length == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: CustomSnackBarContent(
                        errorMessage: "You didn't enter your phone number"),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  } else if (phoneNumberController.text.length < 10 &&
                      phoneNumberController.text.length > 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: CustomSnackBarContent(
                        errorMessage:'You entered a missing number, correct it immediately.'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  }else if (emailController.text.length==0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: CustomSnackBarContent(
                        errorMessage:"You diidn't enter your email"),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(emailController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: CustomSnackBarContent(
                        errorMessage:"You entered the email wrongly"),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  }else if (passwordController.text.length==0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: CustomSnackBarContent(
                        errorMessage:"You diidn't enter your password"),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  } else {
                    signup();

                    Fluttertoast.showToast(
                      msg: "You are registered successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.purple,
                      textColor: Colors.white,
                      fontSize: 16,
                    ).then((value) =>{
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => loginPage(),
                        ),
                      )
                    });
                  }
                }
              ),
              SizedBox(height: getHeight / 50),
            ],
          ),
        ),
      ),
    );
  }
  void signup(){
    Map user ={
      'name': nameController.text,
      'surname': surnameController.text,
      'email': emailController.text,
      'phone_number': phoneNumberController.text,
      'password': passwordController.text
    };
    dbRef.push().set(user);
    auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
  }

  void _reqFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(nameFocus);
    });
  }
  
  TextFormField nameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: nameController,
      showCursor: true,
      validator: (value) {
        if(value!.isEmpty){
          return 'Please enter name';
        }else{
          return null;
        }
      },
      focusNode: nameFocus,
      autofocus: false,
      decoration: InputDecoration(
        prefix: Padding(
          padding: EdgeInsets.all(4),
        ),
        labelText: "Name",
        floatingLabelStyle: TextStyle(color: nameFocus.hasPrimaryFocus ?Colors.purple:Colors.red),
        labelStyle: TextStyle(color: Colors.grey[500]),
        hintText: "Enter your name",
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
          Icons.account_circle,
          color: Colors.purple,
        ),
      ),
    );
  }

  TextFormField surnameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: surnameController,
      showCursor: true,
      decoration: InputDecoration(
        prefix: Padding(
          padding: EdgeInsets.all(4),
        ),
        labelText: "Surname",
        floatingLabelStyle: TextStyle(color: Colors.purple),
        labelStyle: TextStyle(color: Colors.grey[500]),
        hintText: "Enter your surname",
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[500]),
        icon: Icon(
          Icons.account_circle,
          color: Colors.purple,
        ),
      ),
    );
  }

  TextFormField emailField(){
    return TextFormField(
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
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[500]),
        icon: Icon(
          Icons.email,
          color: Colors.purple,
        ),
      ),
    );
  }

  TextFormField phoneNumberField(){
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: phoneNumberController,
      showCursor: true,
      decoration: InputDecoration(
        prefix: Padding(
          padding: EdgeInsets.all(4),
        ),
        labelText: "Phone Number",
        floatingLabelStyle: TextStyle(color: Colors.purple),
        labelStyle: TextStyle(color: Colors.grey[500]),
        hintText: "Enter your number",
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[500]),
        icon: Icon(
          Icons.phone_android,
          color: Colors.purple,
        ),
      ),
    );
  }

  TextFormField passwordField(){
    return TextFormField(
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
        icon: Icon(
          Icons.account_circle,
          color: Colors.purple,
        ),
      ),
    );
  }

}