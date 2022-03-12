// ignore_for_file: prefer_const_constructors

import 'package:facelift_constructions/constants.dart';
import 'package:facelift_constructions/models/room.dart';
import 'package:flutter/material.dart';

class RoomScreen extends StatelessWidget {
  final List<RoomPhotos> photos;
  const RoomScreen({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          // toolbarHeight: 75,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          // title: Text("Add House Plan", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black54),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: photos.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => PhotoBox(
                  photo: photos[index],
                  size: size,
                  photos: photos,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                child: Text(
                  "Design a Completmentry Bathroom For Your home with facelift",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ),
              InkWell(
                onTap: () {
                  showAnimatedDialogBox(context, "name");
                },
                child: Container(
                  width: size.width * 0.7,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      border: Border.all(color: pinkColor),
                      borderRadius: BorderRadius.circular(32)),
                  child: Center(child: Text("See More Photos")),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoBox extends StatelessWidget {
  final RoomPhotos photo;
  const PhotoBox({
    Key? key,
    required this.photo,
    required this.size,
    required this.photos,
  }) : super(key: key);

  final List<RoomPhotos> photos;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          photo.image,
          fit: BoxFit.cover,
          height: size.height * 0.5,
          width: size.width,
        ),
      ),
    );
  }
}
