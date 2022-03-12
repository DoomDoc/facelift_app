// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:facelift_constructions/constants.dart';
import 'package:facelift_constructions/premium/newPremiumUser.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import 'progress_page.dart';
import 'sample_bill/sample_bills_list.dart';
import 'sample_laborer/sample_laborer_list.dart';
import 'superviser_widget.dart';
import 'user_house_plan/plan_list.dart';

class PremiumScreen extends StatelessWidget {
  // const PremiumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you really want to exit?'),
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

    if (premiumUser) {
      return StreamBuilder<PremiumDataModel>(
        stream: DatabaseService().userPrmiumDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            premiumName = snapshot.data!.houseName;
            premiumCity = snapshot.data!.city;
            return WillPopScope(
              onWillPop: showExitPopup,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Text(
                            snapshot.data!.houseName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${snapshot.data!.area} Sq Ft",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: pinkColor),
                        ),
                        SizedBox(height: 30),
                        HousePlansList(),
                        Superviser(),
                        SampleLaborerList(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Progress",
                                style: TextStyle(fontSize: 16),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProgressScreen()));
                                },
                                child: Text(
                                  "See All",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: pinkColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 120,
                              width: 120,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CircularProgressIndicator(
                                    value: 0.07,
                                    valueColor:
                                        AlwaysStoppedAnimation(pinkColor),
                                    strokeWidth: 20,
                                    backgroundColor: Colors.grey[400],
                                  ),
                                  Center(
                                    child: Text("7%"),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SampleBillsList()
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
    } else {
      return NewPrimiumUserScreen();
    }
  }
}
