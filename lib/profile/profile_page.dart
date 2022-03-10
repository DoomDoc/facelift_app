// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:facelift_constructions/log_in/welcome.dart';
import 'package:facelift_constructions/profile/accounts_page.dart';
import 'package:facelift_constructions/profile/upload_pic_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/models.dart';
import '../services/auth_service.dart';
import '../services/databases.dart';

class PofileScreen extends StatelessWidget {
  const PofileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    AuthClass authClass = AuthClass();
    return StreamBuilder<Uuser>(
        stream: DatabaseService().userDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WillPopScope(
              onWillPop: showExitPopup,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        ProfilePic(),
                        SizedBox(height: 20),
                        Text(snapshot.data!.name),
                        Text(snapshot.data!.phone),
                        SizedBox(height: 20),
                        ProfileMenu(
                          name: "Edit Account",
                          press: () {
                            // print(authClass.getUid());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccountsScreen()));
                          },
                        ),
                        ProfileMenu(
                          name: "My Site",
                          press: () {},
                        ),
                        ProfileMenu(
                          name: "FAQs",
                          press: () {},
                        ),
                        ProfileMenu(
                          name: "Log Out",
                          press: () async {
                            await authClass.signOut(context: context);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomeScreen()),
                                (route) => false);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            // return Scaffold(
            //   body: Center(child: Text("error")),
            // );
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        });
  }
}

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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          // primary: kPrimaryColor,
          primary: Color(0xffff72b9),
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/images/Camera_icon.svg",
              // color: kPrimaryColor,
              color: Color(0xffff72b9),
              width: 22,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(name)),
            Icon(Icons.arrow_forward_ios),
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
                    : CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/profile.jpg"),
                      ),
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
                          side: BorderSide(color: Colors.white),
                        ),
                        primary: Colors.white,
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadPicScreen()));
                      },
                      child: SvgPicture.asset("assets/images/Camera_icon.svg"),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
