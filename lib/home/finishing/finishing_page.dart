// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../models/finishing.dart';

class FinishingScreen extends StatelessWidget {
  final int id;
  const FinishingScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: id == 0
          ? SingleChildScrollView(
              // scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  FinishingList(
                    materialList: flooringItalian,
                    name: "Italian Marbles",
                  ),
                  FinishingList(
                    materialList: flooringGranite,
                    name: "Granites",
                  ),
                  FinishingList(
                    materialList: flooringOnyx,
                    name: "Onyx Marbles",
                  ),
                  FinishingList(
                    materialList: flooringSize,
                    name: "Tiles by Size",
                  ),
                  FinishingList(
                    materialList: flooringBrand,
                    name: "Tiles by Brand",
                  ),
                ],
              ),
            )
          : id == 1
              ? SingleChildScrollView(
                  // scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      FinishingList(
                        materialList: paintDiv,
                        name: "Paints Diversification",
                      ),
                      FinishingList(
                        materialList: paintBrand,
                        name: "Brands",
                      ),
                    ],
                  ),
                )
              : id == 2
                  ? SingleChildScrollView(
                      // scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          FinishingList(
                            materialList: doors,
                            name: "Doors",
                          ),
                          FinishingList(
                            materialList: doorFrames,
                            name: "Door & Window Frames",
                          ),
                          FinishingList(
                            materialList: doorsLatest,
                            name: "Latest Accessories",
                          ),
                          FinishingList(
                            materialList: doorsCube,
                            name: "Cube Shelvings",
                          ),
                          FinishingList(
                            materialList: doorsLight,
                            name: "Furniture Lights",
                          ),
                        ],
                      ),
                    )
                  : id == 3
                      ? SingleChildScrollView(
                          // scrollDirection: Axis.horizontal,
                          child: Column(
                            children: [
                              FinishingList(
                                materialList: LightTechnologies,
                                name: "Lighting Technologies",
                              ),
                              FinishingList(
                                materialList: LightChandeliers,
                                name: "Chandeliers",
                              ),
                              FinishingList(
                                materialList: LightPandent_lamp,
                                name: "Pendant Lamps",
                              ),
                              FinishingList(
                                materialList: Lightbrand,
                                name: "Brands",
                              ),
                            ],
                          ),
                        )
                      : id == 4
                          ? SingleChildScrollView(
                              // scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  FinishingList(
                                    materialList: kitchenLatest,
                                    name: "Latest Technologies",
                                  ),
                                  FinishingList(
                                    materialList: kitchenType,
                                    name: "Types",
                                  ),
                                  FinishingList(
                                    materialList: kitchenBrands,
                                    name: "Brands",
                                  ),
                                ],
                              ),
                            )
                          : SingleChildScrollView(
                              // scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  FinishingList(
                                    materialList: bathSpecial,
                                    name: "Facelift Specialties",
                                  ),
                                  FinishingList(
                                    materialList: bathColor,
                                    name: "Colors",
                                  ),
                                  FinishingList(
                                    materialList: bathBrands,
                                    name: "Brands",
                                  ),
                                ],
                              ),
                            ),
    );
  }
}

class FinishingList extends StatelessWidget {
  final List<FinishingMaterial> materialList;
  final String name;
  const FinishingList({
    Key? key,
    required this.materialList,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(name),
        ),
        Container(
          padding: EdgeInsets.only(top: 16, left: 8),
          height: 200,
          // height: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: materialList.length,
            itemBuilder: (context, index) => FinishingPageCard(
              material: materialList[index],
            ),
          ),
        ),
      ],
    );
  }
}

class FinishingPageCard extends StatelessWidget {
  final FinishingMaterial material;
  const FinishingPageCard({
    Key? key,
    required this.material,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(24),
            shadowColor: Colors.white,
            child: SizedBox(
              height: 150,
              width: 150,
              // color: Colors.black12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  material.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              material.name,
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
