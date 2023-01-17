import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lancode/components/default_button.dart';
import 'package:lancode/util/constants.dart';
import 'package:lancode/components/custom_snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lancode/profile/splash/animated_splash_screen.dart';
import 'package:lancode/Profile/edit_picture.dart';

class Update extends StatefulWidget {
  const Update({Key? key, required this.userK}) : super(key: key);

  final String userK;

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
         title: Text(
          'EDIT PROFILE',
          style: GoogleFonts.bebasNeue(
            color: Colors.purple[700],
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
                  height: getHeight / 50,
                ),
                EditProfile(userKey: widget.userK),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.userKey}) : super(key: key);

  final String userKey;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final name = TextEditingController();
  final surname = TextEditingController();
  final email = TextEditingController();
  final phoneN = TextEditingController();

  final _validationKey = GlobalKey<FormState>();
  final nameFocus = FocusNode();
  final surnameFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneNumberFocus = FocusNode();

  final FirebaseAuth auth = FirebaseAuth.instance;

  late DatabaseReference dbRef;

  String photo1 = FirebaseAuth.instance.currentUser!.photoURL.toString();
  String photo2 = 'https://firebasestorage.googleapis.com/v0/b/mobileprogramming-c9890.appspot.com/o/files%2Ficon.jpg?alt=media&token=c84cb5f8-1e38-4a0b-b83f-f3d6cd2d2cf0';

  void initState() {
    setState(() {});
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Users');
    getUserData();
  }

  void getUserData() async {
    DataSnapshot snapshot = await dbRef.child(widget.userKey).get();

    Map user = snapshot.value as Map;

    name.text = user['name'];
    phoneN.text = user['phone_number'];
    surname.text = user['surname'];
    email.text = user['email'];
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildProfilePicField(),
                SizedBox(height: getHeight / 40),
                buildNameFormField(),
                SizedBox(height: getHeight / 20),
                buildSurnameFormField(),
                SizedBox(height: getHeight / 20),
                buildEmailFormField(),
                SizedBox(height: getHeight / 20),
                buildPhoneNumberFormField(),
                SizedBox(height: getHeight / 20),
                defaultButton(
                  onPress: () async {
                     _validationKey.currentState?.validate();
                    if (name.text.length == 0) {
                      nameFocus.requestFocus();
                    } else if (surname.text.length == 0) {
                      surnameFocus.requestFocus();
                    }else if (email.text.length==0) {
                      emailFocus.requestFocus();
                    }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(email.text)) {
                      emailFocus.requestFocus();
                    } else if (phoneN.text.length == 0) {
                      phoneNumberFocus.requestFocus();
                    } else if (phoneN.text.length < 10 &&
                        phoneN.text.length > 0) {
                      phoneNumberFocus.requestFocus();
                    }  else {
                      List<String> emails = [];
                      List<String> phones = [];
                      List<Customer> items = await customerListMaker();

                      for (var element in items) {
                        if (element.email == email.text) {
                          continue;
                        } else {
                          emails.add(element.email);
                        }
                      }
                      for (var element in items) {
                        if (element.phone == phoneN.text) {
                          continue;
                        } else {
                          phones.add(element.phone);
                        }
                      }
                      if (emails.contains(email.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: CustomSnackBarContent(
                                errorMessage:
                                    "The email already exists, try another email"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                        );
                      }else if(phones.contains(phoneN.text)){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: CustomSnackBarContent(
                                errorMessage:
                                    "The number already exists, try another number"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                        );
                      } else {
                        Map<String, String> users = {
                          'name': name.text,
                          'phone_number': phoneN.text,
                          'surname': surname.text,
                          'email': email.text,
                        };

                        dbRef
                            .child(widget.userKey)
                            .update(users)
                            .then((value) => {});
                        FirebaseAuth.instance.currentUser!.updateDisplayName(name.text);
                        FirebaseAuth.instance.currentUser!.updateEmail(email.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SplashScreenPAnimated(),
                          ),
                        );
                        Fluttertoast.showToast(
                          msg: "Your profile has been edited successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.purple,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      }
                    }
                  },
                  text: 'Save Changes',
                ),
                SizedBox(height: getHeight / 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center buildProfilePicField() {
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.purple),
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                ((FirebaseAuth.instance.currentUser?.photoURL != null)
                    ? photo1
                    : photo2),
                height: getHeight / 6,
                width: getWidth / 3,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4,
                  color: Colors.white,
                ),
                color: Colors.purple,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePicture(
                        userKey: widget.userKey,
                      ),
                    ),
                  );
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: name,
      showCursor: true,
      cursorColor: Colors.purple,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
        floatingLabelBehavior: FloatingLabelBehavior.always,
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

  TextFormField buildSurnameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if(value!.isEmpty){
          return 'Please enter surname';
        }else{
          return null;
        }
      },
      focusNode: surnameFocus,
      autofocus: false,
      controller: surname,
      showCursor: true,
      cursorColor: Colors.purple,
      decoration: InputDecoration(
        prefix: Padding(
          padding: EdgeInsets.all(4),
        ),
        labelText: "Surname",
        floatingLabelStyle: TextStyle(color: Colors.purple),
        labelStyle: TextStyle(color: Colors.grey[500]),
        hintText: "Enter your surname",
        floatingLabelBehavior: FloatingLabelBehavior.always,
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

  TextFormField buildEmailFormField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: email,
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
        floatingLabelBehavior: FloatingLabelBehavior.always,
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

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLength: 10,
      controller: phoneN,
      showCursor: false,
      cursorColor: Colors.purple,
      validator: (value) {
        if(value!.isEmpty){
          return 'Please enter phone number';
        }else if(phoneN.text.length < 10 && phoneN.text.length > 0){
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
        labelText: "Phone number",
        floatingLabelStyle: TextStyle(color: Colors.purple),
        labelStyle: TextStyle(color: Colors.grey[500]),
        hintText: "Enter your phone",
        floatingLabelBehavior: FloatingLabelBehavior.always,
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
}
