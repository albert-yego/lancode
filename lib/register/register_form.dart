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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Expanded(
        child: SingleChildScrollView(
          key: _validationKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: getHeight / 40),
              nameField(),
              SizedBox(height: getHeight / 20),
              surnameField(),
              SizedBox(height: getHeight / 20),
              emailField(),
              SizedBox(height: getHeight / 20),
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
                    surnameFocus.requestFocus();
                  }else if (emailController.text.length==0) {
                    emailFocus.requestFocus();
                  }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(emailController.text)) {
                    emailFocus.requestFocus();
                  } else if (phoneNumberController.text.length == 0) {
                    phoneNumberFocus.requestFocus();
                  } else if (phoneNumberController.text.length < 10 &&
                      phoneNumberController.text.length > 0) {
                    phoneNumberFocus.requestFocus();
                  }else if (passwordController.text.length==0) {
                    passwordFocus.requestFocus();
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
  void signup() async{
    try{
      await auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      Map user ={
        'name': nameController.text,
        'surname': surnameController.text,
        'photoURL': 'https://firebasestorage.googleapis.com/v0/b/mobileprogramming-c9890.appspot.com/o/files%2Ficon.jpg?alt=media&token=c84cb5f8-1e38-4a0b-b83f-f3d6cd2d2cf0',
        'email': emailController.text,
        'auth_uid': '',
        'phone_number': phoneNumberController.text,
        'password': passwordController.text
      };
      dbRef.push().set(user);
    }on FirebaseAuthException catch (e){
      if(e.code=='email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomSnackBarContent(
              errorMessage:
                  "Email is being used."),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
      }
      if(e.code=='invalid-email'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomSnackBarContent(
              errorMessage:
                  "Invalid email."),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
      }
      if(e.code=='weak-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomSnackBarContent(
              errorMessage:
                  "Put a stronger password."),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
      }
    }catch (e){
      print(e.toString());
    }
    
  }

  // void _reqFocus(){
  //   setState(() {
  //     FocusScope.of(context).requestFocus(nameFocus);
  //   });
  // }
  
  TextFormField nameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: nameController,
      showCursor: true,
      cursorColor: Colors.purple,
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
        floatingLabelStyle: TextStyle(color: Colors.purple),
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: surnameController,
      showCursor: true,
      cursorColor: Colors.purple,
      validator: (value) {
        if(value!.isEmpty){
          return 'Please enter surname';
        }else{
          return null;
        }
      },
      focusNode: surnameFocus,
      autofocus: false,
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

  TextFormField emailField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: emailController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      showCursor: true,
      validator: (value) {
        if(value!.isEmpty){
          return 'Please enter email';
        }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)){
          return 'incorrect email';
        }else{
          return null;
        }
      },
      focusNode: emailFocus,
      autofocus: false,
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      showCursor: true,
      cursorColor: Colors.purple,
      maxLength: 10,
      validator: (value) {
        if(value!.isEmpty){
          return 'Please enter phone number';
        }else if(phoneNumberController.text.length < 10 && phoneNumberController.text.length > 0){
          return 'incomplete phone number';
        }else{
          return null;
        }
      },
      focusNode: phoneNumberFocus,
      autofocus: false,
      decoration: InputDecoration(
        prefix: Padding(
          padding: EdgeInsets.all(4),
          child: Text('+90'),
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
          Icons.account_circle,
          color: Colors.purple,
        ),
      ),
    );
  }

}