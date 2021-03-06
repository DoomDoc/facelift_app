// ignore_for_file: prefer_const_constructors

import 'package:facelift_constructions/models/raw.dart';
import 'package:flutter/material.dart';

import '../get_premium_button.dart';

class RawSceen extends StatelessWidget {
  final RawMaterial material;
  const RawSceen({Key? key, required this.material}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(material.image),
              ),
            ),
            Text(
              material.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                material.description,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        material.p1,
                        height: 100,
                        width: 120,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        material.p2,
                        height: 100,
                        width: 120,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        material.p3,
                        height: 100,
                        width: 120,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: GetPremiumButton(),
            )
          ],
        ),
      ),
    );
  }
}
