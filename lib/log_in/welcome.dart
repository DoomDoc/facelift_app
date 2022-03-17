import 'package:facelift_constructions/constants.dart';
import 'package:flutter/material.dart';

import 'phone_auth_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPage = 0;

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

    List contentList = [
      welcomeContent(
        context,
        "Manage your house construction",
        "Upload bills, get ideas, track progress, store plans, make payments, and so much more right from your smartphone…",
        "assets/images/1.png",
        "Welcome",
      ),
      welcomeContent(
        context,
        "Construction laborers",
        "Appoint, overlook, replace, raise an issue with the on-site laborers in one click from the app.",
        "assets/images/2.png",
        "",
      ),
      welcomeContent(
        context,
        "Building materials",
        "Over 750 highest quality materials & products to choose from 170+ National & International brands directly at your site…",
        "assets/images/3.png",
        "",
      ),
    ];

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFC5E2),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  flex: 7,
                  child: PageView.builder(
                      onPageChanged: (value) =>
                          setState(() => currentPage = value),
                      itemCount: 3,
                      itemBuilder: (context, index) => contentList[index])),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(),
                    // currentPage != 3
                    //     ? Material(
                    //         elevation: 10,
                    //         // shadowColor: Colors.white,
                    //         borderRadius: BorderRadius.circular(32),
                    //         child: Container(
                    //           height: 60,
                    //           width: 250,
                    //           decoration: BoxDecoration(
                    //             border: Border.all(color: pinkColor),
                    //             borderRadius: BorderRadius.circular(32),
                    //             color: const Color(0xFFD9D9D9),
                    //           ),
                    //           child: const Center(child: Text("Next")),
                    //         ),
                    //       )
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PhoneAuthScreen())),
                      child: Material(
                        elevation: 10,
                        // shadowColor: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        child: Container(
                          height: 60,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: pinkColor,
                          ),
                          child: const Center(child: Text("Sign Up")),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              // const Text(
              //   "Welcome",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              // ),
              // const SizedBox(height: 24),
              // welcomeButton("Continue with Phone", pinkColor, context),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 500),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: 6,
      decoration: BoxDecoration(
        color: currentPage == index ? pinkColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget welcomeContent(BuildContext context, String heading, String text,
      String image, String welcome) {
    return Column(
      children: [
        const Spacer(flex: 2),
        Text(welcome, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 20),
        Container(
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: const BoxDecoration(color: Color(0xFFFFC5E2)),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        const Spacer(flex: 3),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            heading,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const Spacer(flex: 7),
      ],
    );
  }

  Widget welcomeButton(bool next, VoidCallback press) {
    return InkWell(
      onTap: () => next
          ? press
          : () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PhoneAuthScreen()));
            },
      child: Material(
        elevation: 10,
        // shadowColor: Colors.white,
        borderRadius: BorderRadius.circular(32),
        child: Container(
          height: 60,
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(
              width: next ? 1 : 0,
              color: pinkColor,
            ),
            borderRadius: BorderRadius.circular(32),
            color: next ? const Color(0xFFD9D9D9) : pinkColor,
          ),
          child: Center(child: Text(next ? "Next" : "")),
        ),
      ),
    );
  }

  // Widget welcomeButton(String name, Color color, BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  // if (name == "Continue with Phone") {
  // Navigator.push(context,
  //     MaterialPageRoute(builder: (context) => const PhoneAuthScreen()));
  //       }
  //       // else {
  //       //   Navigator.push(context,
  //       //       MaterialPageRoute(builder: (context) => NewUserScreen()));
  //       // }
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 48),
  //       child: Material(
  //         borderRadius: BorderRadius.circular(16),
  //         elevation: 10,
  //         child: Container(
  //           height: 75,
  //           decoration: BoxDecoration(
  //             color: color,
  //             borderRadius: BorderRadius.circular(16),
  //           ),
  //           child: Center(child: Text(name)),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
