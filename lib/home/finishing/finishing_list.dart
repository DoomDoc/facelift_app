// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'finishing_page.dart';

class FinishingList extends StatelessWidget {
  const FinishingList({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FinishingRow(
          size: size,
          name1: "Flooring",
          name2: "Paints and Polishes",
          image1: "assets/finishing/flooring.jpg",
          image2: "assets/finishing/paint.jpg",
          id1: 0,
          id2: 1,
        ),
        FinishingRow(
          size: size,
          name1: "Doors and Accessories",
          name2: "Lighting",
          image1: "assets/finishing/door.jpg",
          image2: "assets/finishing/lighting.jpg",
          id1: 2,
          id2: 3,
        ),
        FinishingRow(
          size: size,
          name1: "Kitchen",
          name2: "Bathroom",
          image1: "assets/finishing/kitchen.jpg",
          image2: "assets/finishing/bathroom.jpg",
          id1: 4,
          id2: 5,
        ),
      ],
    );
  }
}

class FinishingRow extends StatelessWidget {
  final String image1;
  final String name1;
  final int id1;
  final String image2;
  final String name2;
  final int id2;
  const FinishingRow({
    Key? key,
    required this.size,
    required this.name1,
    required this.image1,
    required this.id1,
    required this.name2,
    required this.image2,
    required this.id2,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FinishingCard(
          size: size,
          name: name1,
          image: image1,
          id: id1,
        ),
        FinishingCard(
          size: size,
          name: name2,
          image: image2,
          id: id2,
        ),
      ],
    );
  }
}

class FinishingCard extends StatelessWidget {
  final String image;
  final String name;
  final int id;
  const FinishingCard({
    Key? key,
    required this.size,
    required this.name,
    required this.image,
    required this.id,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FinishingScreen(id: id)),
        ),
        child: Material(
            elevation: 10,
            // shadowColor: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: size.width * 0.47,
              height: size.height * 0.19,
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 4,
                      ),
                      // constraints: BoxConstraints(
                      //   minHeight: size.height * 0.15,
                      //   minWidth: size.width * 0.43,
                      //   maxHeight: size.height * 0.15,
                      //   maxWidth: size.width * 0.43,
                      // ),
                      height: size.height * 0.15,
                      width: size.width * 0.44,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 8),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
