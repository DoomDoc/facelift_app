import 'package:facelift_constructions/constants.dart';
import 'package:flutter/material.dart';

import 'phone_auth_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Welcome",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),
              welcomeButton("Continue with Phone", pinkColor, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget welcomeButton(String name, Color color, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (name == "Continue with Phone") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PhoneAuthScreen()));
        }
        // else {
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: (context) => NewUserScreen()));
        // }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 10,
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(child: Text(name)),
          ),
        ),
      ),
    );
  }
}
