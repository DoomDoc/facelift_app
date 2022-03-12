import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/databases.dart';
import 'sample_laborer_list.dart';

class SelectLaborScreen extends StatelessWidget {
  const SelectLaborScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().userLaborer.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SizedBox(
                  height: 200,
                  child: snapshot.data!.docs.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data!.docs[index]["name"];
                            String skill = snapshot.data!.docs[index]["skill"];
                            String image = snapshot.data!.docs[index]["image"];
                            return UserLaborerCard(
                              name: name,
                              skill: skill,
                              image: image,
                            );
                          })
                      : const CircularProgressIndicator()),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
