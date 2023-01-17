import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lancode/home/home.dart';
import 'package:lancode/components/default_button.dart';
import 'package:lancode/profile/profile_edit.dart';
import 'package:lancode/util/constants.dart';


class profilePage extends StatefulWidget {
  const profilePage({super.key});

  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  String? authcurrent =
      FirebaseAuth.instance.currentUser?.email;
  String photo1 = FirebaseAuth.instance.currentUser!.photoURL.toString();
  String photo2 = '';

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => homePage(),
              )
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          )
        )
      ),
      body: FutureBuilder(
        future: customerAccountDetails(authcurrent!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return displayUserInformation(context, snapshot);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    Map signedInCustomer = snapshot.data as Map;

    return Padding(
      padding: EdgeInsets.all(getHeight / 40),
      child: Expanded(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
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
                ],
              ),
            ),
            SizedBox(height: getHeight / 20),
            TextField(
              readOnly: true,
              enabled: false,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      bottom: getHeight / 100, left: getWidth / 100),
                  labelText: "Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "${signedInCustomer['name']}"+" ${signedInCustomer['surname']}",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            SizedBox(height: getHeight / 40),
            TextField(
              readOnly: true,
              enabled: false,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      bottom: getHeight / 100, left: getWidth / 100),
                  labelText: "Email",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "${signedInCustomer['email']}",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            SizedBox(height: getHeight / 40),
            TextField(
              enabled: false,
              readOnly: true,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      bottom: getHeight / 100, left: getWidth / 100),
                  labelText: "Phone Number",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "+90${signedInCustomer['phone_number']}",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            SizedBox(height: getHeight / 9),
            defaultButton(
              text: "Edit Profile",
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>Update(userK: signedInCustomer['uid'])
                  )
                );
              }
            ),
          ],
        )),
      ),
    );
  }
}