import 'package:flutter/material.dart';

class ViewBillScreen extends StatelessWidget {
  final String name;
  final String image;
  final int amount;
  final int warrenty;
  final int date;
  final int month;
  final int year;
  const ViewBillScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.amount,
    required this.warrenty,
    required this.date,
    required this.month,
    required this.year,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(name),
          Text(image),
          Text(amount.toString()),
          Text(warrenty.toString()),
          Text(date.toString()),
          Text(month.toString()),
          Text(year.toString()),
        ],
      ),
    );
  }
}
