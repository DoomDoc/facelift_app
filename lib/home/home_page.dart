// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables,

import 'package:facelift_constructions/constants.dart';
import 'package:flutter/material.dart';

import 'finishing/finishing_list.dart';
import 'lobor/labor_list.dart';
import 'raw/raw_list.dart';
import 'tools/tools_list.dart';
import 'green_spaces.dart';
import 'logo.dart';
import 'luxury_elements.dart';
import 'premium.dart';
import 'rooms/room_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: <Widget>[
                InkWell(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 40,
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                          color: pinkColor,
                          borderRadius: BorderRadius.circular(11)),
                      child: Center(
                          child: Text('No',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))),
                    ),
                  ),
                ),
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
                      child: Center(
                          child: Text('Yes',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
          ) ??
          false;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 426) {
          return WillPopScope(
            onWillPop: showExitPopup,
            child: Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Logo(size: size),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Text(
                          "House Room Photos",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                      RoomGrid(size: size, s: constraints.maxWidth < 330),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, top: 32, bottom: 16),
                        child: Text(
                          "Labor",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                      LaborList(size: size),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, top: 32, bottom: 16),
                        child: Text(
                          "Latest Tools and Machinery",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ToolsList(size: size),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, top: 32, bottom: 16),
                        child: Text(
                          "Don't just live in your home, feel it!",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                      LuxuryElements(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, bottom: 24, top: 32),
                        child: Text(
                          "Raw Materials",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                      ),
                      RawList(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, bottom: 24, top: 32),
                        child: Text(
                          "Finishing Materials",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                      ),
                      FinishingList(size: size),
                      premiumUser == false
                          ? PremiumWidget(
                              size: size, s: constraints.maxWidth > 335)
                          : SizedBox(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 32),
                        child: Text(
                          "Facelift promotes Green spaces",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                      GreenSpaces(),
                      SizedBox(
                        height: size.height * 0.1,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Text(
                "Screen under maintainance. Try using your phone in potrait mode."),
          );
        }
      },
    );
    // extendBody: true,
    // bottomNavigationBar: Container(
    //   decoration: BoxDecoration(
    //     color: pinkColor,
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(16),
    //       topRight: Radius.circular(16),
    //     ),
    //   ),
    //   height: 60,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       GestureDetector(
    //         onTap: () => Navigator.push(context,
    //             MaterialPageRoute(builder: (context) => PofileScreen())),
    //         child: Icon(Icons.account_circle_outlined),
    //       ),
    //       Icon(Icons.maps_home_work),
    //       GestureDetector(
    //         onTap: () => Navigator.push(context,
    //             MaterialPageRoute(builder: (context) => PremiumScreen())),
    //         child: Icon(Icons.fireplace_outlined),
    //       ),
    //     ],
    //   ),
    // ),
  }
}
