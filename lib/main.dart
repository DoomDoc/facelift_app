// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:facelift_constructions/log_in/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/models.dart';
import 'services/auth_service.dart';
import '../constants.dart';
import 'services/databases.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    String? tokne = await authClass.getPhone();
    if (tokne != null) {
      setState(() {
        userLogedIn = true;
        number = tokne;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userLogedIn != true) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Facelift Constructions',
        home: WelcomeScreen(),
      );
    } else {
      return StreamBuilder<UserPremiumBool>(
        stream: DatabaseService().userPremiumBoolStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && userLogedIn == true) {
            premiumUser = snapshot.data!.premium;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Facelift Constructions',
              home: Scaffold(
                body: screens[iindex],
                extendBody: true,
                bottomNavigationBar: Visibility(
                  visible: navBarVisibility,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 72),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        selectedItemColor: Colors.black,
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        backgroundColor: pinkColor,
                        currentIndex: iindex,
                        onTap: (val) {
                          setState(() => iindex = val);
                        },
                        items: [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.account_circle_outlined),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.fireplace),
                            label: "",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }
        },
      );
    }
  }
}
