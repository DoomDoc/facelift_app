import 'package:facelift_constructions/models/tools.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../dialogs.dart';
import '../../services/databases.dart';

class ToolsSceen extends StatelessWidget {
  final Tools tool;
  const ToolsSceen({Key? key, required this.tool}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 65,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black54),
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
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  tool.description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  final time = DateTime.now().millisecondsSinceEpoch;
                  DatabaseService().updateUserRequestTools(
                      time, true, tool.name.replaceAll(' ', ''));

                  showSimpleAnimatedDialogBox(
                      context, "Request Placed Succesfully", 3, "4.png");
                },
                child: Container(
                  height: 45,
                  width: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: pinkColor,
                  ),
                  child: Center(child: Text("Get ${tool.name}")),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(32),
              //   child: GetPremiumButton(),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
