import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lancode/components/default_button.dart';
import 'package:lancode/util/constants.dart';
import 'package:lancode/components/custom_snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:lancode/profile/splash/animated_splash_screen.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:base_x/base_x.dart';

class EditProfilePicture extends StatefulWidget {
  const EditProfilePicture({Key? key, required this.userKey}) : super(key: key);

  final String userKey;

  @override
  State<EditProfilePicture> createState() => _EditProfilePictureState();
}

class _EditProfilePictureState extends State<EditProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Picture'),
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
                Text(
                  'Choose Profile Picture',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: getHeight / 1500,
                ),
                Text(
                  "Choose from gallery",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: getHeight / 10,
                ),
                EditPicture(userKey: widget.userKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditPicture extends StatefulWidget {
  const EditPicture({Key? key, required this.userKey}) : super(key: key);

  final String userKey;

  @override
  State<EditPicture> createState() => _EditPictureState();
}

class _EditPictureState extends State<EditPicture> {
  Uint8List? _image;
  String photo1 = FirebaseAuth.instance.currentUser!.photoURL.toString();
  String photo2 = '';

  bool newPhotoExists = false;
  bool oldPhotoExists = true;

  Uint8List? _img;
  Uint8List _imgexample = new Uint8List(8);

  final storageref = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: getHeight / 40),
                buildProfilePic(),
                buildChoosenProfilePic(),
                SizedBox(height: getHeight / 40),
                defaultButton(
                    text: 'Upload',
                    onPress: () async {
                      Uint8List? s = _image;
                      if (s != null) {
                        String url = await uploadImage(s);
                        FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
                        FirebaseDatabase.instance.ref().child('Users/${widget.userKey}').update({
                          'photoURL': url
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SplashScreenPAnimated(),
                          ),
                        );
                        Fluttertoast.showToast(
                          msg: "Photo Uploaded",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.purple,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      }
                    })
              ]),
        ),
      ),
    );
  }

  Visibility buildProfilePic() {
    return Visibility(
      child: ClipOval(
        child: Container(
          width: 220.0,
          height: 220.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  (FirebaseAuth.instance.currentUser?.photoURL != null)
                      ? photo1
                      : photo2),
            ),
          ),
          child: TextButton(
              child: Padding(
                padding: EdgeInsets.all(0.0),
                child: null,
              ),
              onPressed: () {
                newPhotoExists = true;
                oldPhotoExists = false;
                getImage();
              }),
        ),
      ),
      visible: oldPhotoExists,
    );
  }

  Visibility buildChoosenProfilePic() {
    return Visibility(
      child: ClipOval(
        child: Container(
          width: 220.0,
          height: 220.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: MemoryImage((_img != null) ? _img! : _imgexample),
            ),
          ),
          child: TextButton(
              child: Padding(
                padding: EdgeInsets.all(0.0),
                child: null,
              ),
              onPressed: () {
                newPhotoExists = true;
                oldPhotoExists = false;
                getImage();
              }),
        ),
      ),
      visible: newPhotoExists,
    );
  }

  void getImage() async {
    try{
        Uint8List pickedFile = await pickImage(ImageSource.gallery);

        setState(() {
          _image = pickedFile;
          _img = pickedFile;
        });
      }on TypeError catch (e){
        if(e.toString() == "type 'Null' is not a subtype of type 'Uint8list'"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: CustomSnackBarContent(
                errorMessage:
                    "No image was selected"),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ));
        }
      } catch (e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomSnackBarContent(
              errorMessage:
                  "Invalid Image.Select again please"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
      }
  }

  Future<String> uploadImage(Uint8List file) async {
    final path = 'files/${FirebaseAuth.instance.currentUser?.uid}';
    Reference profileref = await storageref.child(path);
    UploadTask uploadTask = profileref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagepicker = ImagePicker();
    XFile? _file = await _imagepicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No image Selected');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              CustomSnackBarContent(errorMessage: "You didn't pick an image"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    }
  }
}
