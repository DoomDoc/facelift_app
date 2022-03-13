// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';

import 'home/home_page.dart';
import 'premium/premium_page.dart';
import 'profile/profile_page.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

var pinkColor = Color(0xFFFF72B9);
var premiumUser = false;
var iindex = 1;
var valueChose;
var stateChose;
var premiumName = "";
var premiumCity = "";
var houseWidth = 0;
var houseLength = 0;
var houseSize = houseWidth * houseLength;
var userLogedIn = false;
var userName = "";
var userMobile = 0;
String? number = "0";
String userrName = "";
bool navBarVisibility = true;
var screens = [PofileScreen(), HomeScreen(), PremiumScreen()];
bool crossClick = false;

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// void showModalDialogBox(BuildContext context, String name) => showDialog(
//       context: context,
//       builder: (_) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.only(right: 16, top: 5),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: const [
//                   Icon(
//                     Icons.cancel_outlined,
//                     color: Colors.black54,
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.network(
//                     "https://cdn.searchenginejournal.com/wp-content/uploads/2019/08/c573bf41-6a7c-4927-845c-4ca0260aad6b-1520x800.jpeg"),
//               ),
//             ),
//             // SizedBox(height: 15),
//             // Text("name"),
//           ],
//         ),
//       ),
//     );

void showImageDialogBox(BuildContext context, String image) =>
    showAnimatedDialog(
      barrierDismissible: true,
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          crossClick = true;
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.network(image),
                )
              ],
            ),
          ),
        );
      },
    );

Future<void> showAnimatedDialogBox(BuildContext context, String name) async {
  Timer _timer = Timer(Duration(seconds: 3), () {
    Navigator.of(context).pop();
  });
  showAnimatedDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          child: SizedBox(
            height: 305,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          size: 24,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 200,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          "assets/images/modal1.png",
                        )),
                  ),
                ),
                SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    barrierDismissible: true,
    animationType: DialogTransitionType.slideFromBottom,
    curve: Curves.fastOutSlowIn,
    duration: Duration(seconds: 1),
  ).then((value) {
    if (_timer.isActive) {
      _timer.cancel();
    }
  });
}
