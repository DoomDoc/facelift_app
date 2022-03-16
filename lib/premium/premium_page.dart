import 'package:facelift_constructions/constants.dart';
import 'package:facelift_constructions/premium/new_premium_user.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import 'progress_page.dart';
import 'sample_bill/sample_bills_list.dart';
import 'sample_laborer/sample_laborer_list.dart';
import 'superviser_widget.dart';
import 'user_house_plan/plan_list.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({Key? key}) : super(key: key);

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
              content: const Text('Do you really want to exit?'),
              actions: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 40,
                      width: size.width * 0.3,
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
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${snapshot.data!.area} Sq Ft",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: pinkColor),
                        ),
                        const SizedBox(height: 30),
                        const HousePlansList(),
                        const Superviser(),
                        const SampleLaborerList(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Progress",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProgressScreen()));
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
                        StreamBuilder<UserProgressModel>(
                            stream: DatabaseService().userProgressStream,
                            builder: (context, snapshot) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        CircularProgressIndicator(
                                          value: snapshot.hasData
                                              ? snapshot.data!.overAllvalue
                                              : 0.07,
                                          valueColor:
                                              AlwaysStoppedAnimation(pinkColor),
                                          strokeWidth: 20,
                                          backgroundColor: Colors.grey[400],
                                        ),
                                        Center(
                                          child: Text(snapshot.hasData
                                              ? "${snapshot.data!.percentage}%"
                                              : "7%"),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                        const SampleBillsList()
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    } else {
      return const NewPrimiumUserScreen();
    }
  }
}
