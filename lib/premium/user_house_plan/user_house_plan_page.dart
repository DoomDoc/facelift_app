// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:facelift_constructions/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/databases.dart';

class UserHousePlanScreen extends StatefulWidget {
  const UserHousePlanScreen({Key? key}) : super(key: key);

  @override
  State<UserHousePlanScreen> createState() => _UserHousePlanScreenState();
}

class _UserHousePlanScreenState extends State<UserHousePlanScreen> {
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadUrl;
  String? name;
  bool isLoading = false;

  void showPickerDialogBox(BuildContext context) => showAnimatedDialog(
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottom,
        curve: Curves.fastOutSlowIn,
        duration: Duration(seconds: 1),
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose option"),
            content: SingleChildScrollView(
              child: ListBody(children: [
                ListTile(
                  onTap: () {
                    imagePickerFunc();
                    Navigator.pop(context);
                  },
                  title: Text("Gallery"),
                ),
                ListTile(
                  onTap: () {
                    imagePickerCameraFunc();
                    Navigator.pop(context);
                  },
                  title: Text("Camera"),
                ),
              ]),
            ),
          );
        },
      );

  Future imagePickerFunc() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar(context, "No file");
      }
    });
  }

  Future imagePickerCameraFunc() async {
    final pick = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar(context, "No file");
      }
    });
  }

  Future uploadImage() async {
    final postId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("$number/housePlans")
        .child("post_$postId");
    await ref.putFile(_image!);
    downloadUrl = await ref.getDownloadURL();
    // print(downloadUrl);

    await DatabaseService()
        .updateUserHousePlan(name, downloadUrl!)
        .whenComplete(() {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "uploaded");
      Navigator.pop(context);
    });
  }

  // showSnackBar(String text) {
  //   final snackBar = SnackBar(content: Text(text));
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text("Add House Plan", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      showPickerDialogBox(context);
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: _image != null
                            ? Image.file(_image!)
                            : Text("Add Image"),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 16),
                child: SizedBox(
                  height: 50,
                  width: size.width * 0.9,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    onChanged: (val) => setState(() {
                      name = val;
                    }),
                    decoration: InputDecoration(
                      hintText: "What is this Plan?",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                      // contentPadding: EdgeInsets.only(left: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : InkWell(
                      onTap: () {
                        if (_image != null) {
                          setState(() {
                            isLoading = true;
                          });
                          uploadImage();
                        } else {
                          showSnackBar(context, "error up");
                        }
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(32),
                        elevation: 10,
                        shadowColor: Colors.white,
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: pinkColor,
                          ),
                          child: Center(child: Text("Upload")),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
