import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lancode/Profile/profile_page.dart';
import 'package:lancode/home/splash/splash.dart';

import '../util/constants.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    if(FirebaseAuth.instance.currentUser!.displayName==null||FirebaseAuth.instance.currentUser!.displayName==null){
      updater();
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Center(),
      drawer: Drawer(
        child: Container(
          color: Colors.purple[200],
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profilePage(),
                      ));
                },
                child: Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async{
                  await auth.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SplashScreenHSOAnimated()
                    )
                  ).then((value) => null);
                  Fluttertoast.showToast(
                    msg: "You have signed out successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.purple,
                    textColor: Colors.white,
                    fontSize: 16,
                  );
                },
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}