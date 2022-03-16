// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:facelift_constructions/log_in/welcome.dart';
import 'package:facelift_constructions/profile/accounts_page.dart';
import 'package:facelift_constructions/profile/upload_pic_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../models/models.dart';
import '../services/auth_service.dart';
import '../services/databases.dart';

class PofileScreen extends StatefulWidget {
  const PofileScreen({Key? key}) : super(key: key);

  @override
  State<PofileScreen> createState() => _PofileScreenState();
}

class _PofileScreenState extends State<PofileScreen> {
  _launchUrl(String siteUrl) async {
    final url = siteUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    AuthClass authClass = AuthClass();

    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: const Text('Exit App'),
              content: const Text('Do you want to exit an App?'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(false),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: size.width * 0.3,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(11)),
                          child: const Center(
                              child: Text('No',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white))),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(true),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 40,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(
                              color: pinkColor,
                              borderRadius: BorderRadius.circular(11)),
                          child: const Center(
                              child: Text('Yes',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white))),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ) ??
          false;
    }

    Future<void> showLogoutPopup() async {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Log out'),
          content: const Text('Do you want to Logout of your exiting account?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 40,
                      width: size.width * 0.35,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(11)),
                      child: const Center(
                          child: Text('No',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () async {
                    await authClass.signOut(context: context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()),
                      (route) => false,
                    );
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 40,
                      width: size.width * 0.35,
                      decoration: BoxDecoration(
                          color: pinkColor,
                          borderRadius: BorderRadius.circular(11)),
                      child: const Center(
                          child: Text('Yes',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

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
                        const SizedBox(height: 50),
                        const ProfilePic(),
                        const SizedBox(height: 20),
                        Text(snapshot.data!.name),
                        Text(snapshot.data!.phone),
                        const SizedBox(height: 20),
                        ProfileMenu(
                          name: "Edit Name",
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
                          press: () {
                            _launchUrl('https://www.facelift.construction/');
                          },
                        ),
                        ProfileMenu(
                          name: "FAQs",
                          press: () {
                            _launchUrl(
                                'https://www.facelift.construction/privacy-policy');
                          },
                        ),
                        ProfileMenu(
                          name: "Call Us",
                          press: () {
                            _launchUrl('tel:7207225725');
                          },
                        ),
                        ProfileMenu(
                            name: "Log Out",
                            press: () {
                              showLogoutPopup();
                            }),
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
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
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
            SvgPicture.asset(
              "assets/images/Camera_icon.svg",
              // color: kPrimaryColor,
              color: const Color(0xffff72b9),
              width: 22,
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
