// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';
import 'add_bill_page.dart';

import '../../constants.dart';
import '../../models/sample_bills.dart';

class SampleBillsList extends StatelessWidget {
  const SampleBillsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _name;
    int _amount;
    String _image;
    String nu = "";
    return StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().userHousebill.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 32, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        snapshot.hasData
                            ? snapshot.data!.docs.isNotEmpty
                                ? "$premiumName Bills"
                                : "Sample Bills"
                            : "",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddBillScreen()),
                        ),
                        child: Text(
                          "Add Bills",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        elevation: 10,
                        child: SizedBox(
                          height: 150,
                          width: size.width * 0.4,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data!.docs.isNotEmpty
                                      ? snapshot.data!.docs.length.toString()
                                      : "5",
                                  style:
                                      TextStyle(fontSize: 75, color: pinkColor),
                                ),
                                Text(
                                  "Bills",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        StreamBuilder<UserAmountModel>(
                            stream: DatabaseService().userAmountStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                nu = "Rs ${snapshot.data!.total}";
                              } else {
                                nu = "Rs 0";
                              }
                              return Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(16),
                                child: SizedBox(
                                  height: 85,
                                  width: size.width * 0.5,
                                  child: Center(
                                    child: Text(
                                      nu,
                                      style: TextStyle(
                                          color: pinkColor, fontSize: 38),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        SizedBox(height: 8),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox(
                            height: 50,
                            width: size.width * 0.5,
                            child: Center(
                              child: Text(
                                "Total Amount",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 200,
                  width: size.width,
                  child: snapshot.data!.docs.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            _name =
                                snapshot.data!.docs[index]["name"] ?? "name";
                            _amount = snapshot.data!.docs[index]["amount"] ?? 0;
                            _image = snapshot.data!.docs[index]["image"] ??
                                "https://cdn.searchenginejournal.com/wp-content/uploads/2019/08/c573bf41-6a7c-4927-845c-4ca0260aad6b-760x400.jpeg";
                            return UserBillCard(
                              name: _name,
                              amount: _amount,
                              image: _image,
                            );
                          },
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: sampleBillList.length,
                          itemBuilder: (context, index) =>
                              SampleBillCard(bill: sampleBillList[index]),
                        ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class UserBillCard extends StatelessWidget {
  // final SampleBill bill;
  final String name;
  final int amount;
  final String image;
  const UserBillCard({
    Key? key,
    required this.name,
    required this.amount,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: BorderRadius.circular(16),
            elevation: 10,
            shadowColor: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                image,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, bottom: 4),
            child: Text(
              name,
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "$amount",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}

class SampleBillCard extends StatelessWidget {
  final SampleBill bill;
  const SampleBillCard({
    Key? key,
    required this.bill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddBillScreen()),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              borderRadius: BorderRadius.circular(16),
              elevation: 10,
              shadowColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  bill.image,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 4),
              child: Text(
                bill.name,
                style: TextStyle(fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                bill.amount,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
