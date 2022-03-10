// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new

import 'package:facelift_constructions/services/databases.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/labor.dart';

class GetLaborerScreen extends StatelessWidget {
  const GetLaborerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          itemCount: labor_list.length,
          itemBuilder: (context, index) => GetLaborerCard(
            labor: labor_list[index],
          ),
        ),
      ),
    );
  }
}

class GetLaborerCard extends StatelessWidget {
  final Labor labor;
  const GetLaborerCard({
    Key? key,
    required this.labor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final time = DateTime.now().millisecondsSinceEpoch.toString();
        if (labor.name == "Thekedaar") {
          DatabaseService().updateUserRequestThekedaar(time, true, labor.name);
        } else if (labor.name == "Painter") {
          DatabaseService().updateUserRequestPainter(time, true, labor.name);
        } else if (labor.name == "Mistri") {
          DatabaseService().updateUserRequestMistri(time, true, labor.name);
        } else if (labor.name == "Majdoor") {
          DatabaseService().updateUserRequestMajdoor(time, true, labor.name);
        } else if (labor.name == "Carpenter") {
          DatabaseService().updateUserRequestCarpenter(time, true, labor.name);
        } else if (labor.name == "welder") {
          DatabaseService().updateUserRequestWelder(time, true, labor.name);
        } else if (labor.name == "plumber") {
          DatabaseService().updateUserRequestPlumber(time, true, labor.name);
        } else if (labor.name == "glass labor") {
          DatabaseService().updateUserRequestGlassLabor(time, true, labor.name);
        } else if (labor.name == "electrician") {
          DatabaseService()
              .updateUserRequestElectrician(time, true, labor.name);
        } else if (labor.name == "Marble Mistri") {
          DatabaseService()
              .updateUserRequestMarbleMistri(time, true, labor.name);
        }
        // DatabaseService().updateUserRequestMarbleMistri(time, true, labor.name);
        showAnimatedDialogBox(
            context, "A ${labor.name} will be apointed at $premiumName");
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(20),
                child: Image.asset(labor.image, fit: BoxFit.cover),
              ),
            ),
          ),
          Text("Get ${labor.name}", style: TextStyle(fontSize: 14))
        ],
      ),
    );
  }
}
