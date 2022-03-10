// ignore_for_file: prefer_const_constructors

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
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: ListView.builder(
          itemCount: photos.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => PhotoBox(
            photo: photos[index],
            size: size,
            photos: photos,
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
          height: size.height * 0.7,
          width: size.width,
        ),
      ),
    );
  }
}
