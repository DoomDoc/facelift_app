// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:facelift_constructions/constants.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPicScreen extends StatefulWidget {
  const UploadPicScreen({Key? key}) : super(key: key);

  @override
  _UploadPicScreenState createState() => _UploadPicScreenState();
}

class _UploadPicScreenState extends State<UploadPicScreen> {
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadUrl;
  bool isLoading = false;

  Future imagePickerFunc() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar("No file");
      }
    });
  }

  Future uploadImage() async {
    final postId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("$number/profilePic")
        .child("post_$postId");
    await ref.putFile(_image!);
    downloadUrl = await ref.getDownloadURL();
    // print(downloadUrl);

    await DatabaseService().updateUserProfilePic(downloadUrl).whenComplete(() {
      setState(() {
        isLoading = false;
      });
      showSnackBar("uploaded");
      Navigator.pop(context);
    });
  }

  showSnackBar(String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            height: size.height * 0.7,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Expanded(
                  flex: 4,
                  child: Container(
                    width: size.width * 0.9,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _image != null
                                ? Image.file(_image!)
                                : const Center(
                                    child: Text("nothing"),
                                  ),
                          ),
                          isLoading
                              ? SizedBox(height: 50)
                              : InkWell(
                                  onTap: () {
                                    imagePickerFunc();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: pinkColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(child: Text("Select")),
                                  ),
                                ),
                          SizedBox(height: 20),
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
                                      showSnackBar("error up");
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: pinkColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(child: Text("Upload")),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
