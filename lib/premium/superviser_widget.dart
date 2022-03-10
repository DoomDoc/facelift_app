// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:facelift_constructions/constants.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class Superviser extends StatelessWidget {
  const Superviser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SuperviserModel>(
      stream: DatabaseService().userSuperviserStream,
      builder: (context, snapshot) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SizedBox(height: 10),
                  Text(
                    snapshot.hasData
                        ? "$premiumName Site Supervisor"
                        : "Sample Site Supervisor",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      showAnimatedDialogBox(context,
                          "A site Superviser will be appointed within 24 hours");
                      final time =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      DatabaseService().updateUserRequestSuper(time, true);
                    },
                    child: Text(
                      snapshot.hasData ? "change" : "Appoint",
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CircleAvatar(
                      backgroundColor: pinkColor,
                      radius: 100,
                      backgroundImage: NetworkImage(
                        snapshot.hasData
                            ? snapshot.data!.image
                            : "https://www.colorhexa.com/ffa5d2.png",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          snapshot.hasData ? snapshot.data!.name : "name",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          snapshot.hasData
                              ? "Phone Number - ${snapshot.data!.age}"
                              : "Phone Number",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
