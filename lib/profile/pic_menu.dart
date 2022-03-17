import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/databases.dart';
import 'upload_pic_page.dart';

class ProfileMenu extends StatelessWidget {
  final String name;
  final VoidCallback press;
  const ProfileMenu({
    Key? key,
    required this.name,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          // primary: kPrimaryColor,
          primary: const Color(0xffff72b9),
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            const Icon(
              Icons.camera_alt_outlined,
              // color: kPrimaryColor,
              color: Color(0xffff72b9),
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(name)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserProfilePicModel>(
        stream: DatabaseService().userProfilePicStream,
        builder: (context, snapshot) {
          return SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                snapshot.hasData
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data!.url))
                    : const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/profile.jpg")),
                Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(color: Colors.white),
                        ),
                        primary: Colors.white,
                        backgroundColor: const Color(0xFFF5F6F9),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UploadPicScreen()));
                      },
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
