// ignore_for_file: prefer_const_constructors

import 'package:facelift_constructions/models/tools.dart';
import 'package:flutter/material.dart';

import '../get_premium_button.dart';

class ToolsSceen extends StatelessWidget {
  final Tools tool;
  const ToolsSceen({Key? key, required this.tool}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  tag: tool.image,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        tool.image,
                        width: size.width * 0.95,
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              Text(
                tool.name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  tool.description,
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
