import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lancode/Profile/profile_page.dart';
import 'package:lancode/components/default_button.dart';
import 'package:lancode/home/splash/splash.dart';
import 'package:lancode/questions/start.dart';

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
    if (FirebaseAuth.instance.currentUser!.displayName == null ||
        FirebaseAuth.instance.currentUser!.displayName == null) {
      updater();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[300],
        title: Text(
          'LANCODE',
          style: GoogleFonts.bebasNeue(
            color: Colors.purple[700],
            fontSize: 30,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: getHeight / 6.5, right: getWidth / 80, left: getWidth / 80),
        child: Column(
          children: [
            FutureBuilder(
              future: customerAccountDetails(
                  FirebaseAuth.instance.currentUser!.email),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return buildWelcomeBar(context, snapshot);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }
            ),
            SizedBox(height: getHeight / 10),
            buildLanguageList()
        ]),
      ),
      drawer: Drawer(
        child: Container(
            color: Colors.purple[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    (FirebaseAuth.instance.currentUser!.photoURL.toString()),
                    height: getHeight / 6,
                    width: getWidth / 3,
                  ),
                ),
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
                  onTap: () async {
                    await auth.signOut();
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                            builder: (context) => SplashScreenHSOAnimated()))
                        .then((value) => null);
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
    
  Widget buildLanguageList() {
    List<String> languages = ['Python','Java','HTML','C++','CSS'];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth / 30),
      child: ListView.builder(
        padding: EdgeInsets.only(top: 0),
        itemCount: languages.length,
        itemBuilder: (BuildContext context, int index) {
          String event = languages[index];
          return Container(
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.purple,
              border: Border.all(
                width: 1.5,
                color: Colors.purple,
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.only(top: 2, left: 5),
              title: Text(
                event,
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: 20,
                )
              ),
              onTap: () async {
                if(event=='Python'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>Start()
                    ));
                }
              },
            ),
          );
        },
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget buildWelcomeBar(context, snapshot) {
    Map CurrUser = snapshot.data as Map;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth / 40),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome, ${CurrUser['name']}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: getHeight / 150),
                  Text(
                    "Let's see what new lessons are in store for us",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.purple),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profilePage(),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      CurrUser['photoURL'],
                      height: getHeight / 18,
                      width: getWidth / 9,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]
      ),
    );
  }
}
