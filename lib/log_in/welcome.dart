// ignore_for_file: prefer_const_constructors

import 'package:facelift_constructions/constants.dart';
import 'package:flutter/material.dart';

import 'phone_auth_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

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
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Welcome",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 24),
              // TextFormField(
              //   onChanged: (value) => userrName = value,
              //   decoration: InputDecoration(
              //     constraints: BoxConstraints(minHeight: 50, minWidth: 200),
              //     hintText: "Enter your Name",
              //   ),
              // ),
              // SizedBox(height: 24),
              welcomeButton("Continue with Phone", pinkColor, context),
              // SizedBox(height: 24),
              // welcomeButton("Log In", pinkColor, context),
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
              MaterialPageRoute(builder: (context) => PhoneAuthScreen()));
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
