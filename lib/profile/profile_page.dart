// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:facelift_constructions/log_in/welcome.dart';
import 'package:facelift_constructions/profile/accounts_page.dart';
import 'package:facelift_constructions/profile/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../models/models.dart';
import '../services/auth_service.dart';
import '../services/databases.dart';
import 'pic_menu.dart';

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
                          name: "Edit Account",
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AccountsScreen()));
                          },
                        ),
                        ProfileMenu(
                          name: "Contact Us",
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ContactScreen()));
                          },
                        ),
                        ProfileMenu(
                          name: "FAQs",
                          press: () {
                            _launchUrl(
                                'https://www.facelift.construction/faqs');
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
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
