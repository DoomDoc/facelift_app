// ignore_for_file: prefer_const_constructors

import 'package:facelift_constructions/home/get_premium_button.dart';
import 'package:flutter/material.dart';

import '../../models/labor.dart';

class LaborScreen extends StatelessWidget {
  final Labor labor;
  const LaborScreen({Key? key, required this.labor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Hero(
                  tag: labor.image,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(labor.image)),
                ),
              ),
              Text(
                labor.name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  labor.description,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(32),
                child: GetPremiumButton(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
