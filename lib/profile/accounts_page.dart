// ignore_for_file: use_key_in_widget_constructors

import 'package:facelift_constructions/constants.dart';
import 'package:facelift_constructions/dialogs.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class AccountsScreen extends StatefulWidget {
  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

final _formKey = GlobalKey<FormState>();

class _AccountsScreenState extends State<AccountsScreen> {
  String _currentName = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<Uuser>(
      stream: DatabaseService().userDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 75,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              title: const Text("Update Name",
                  style: TextStyle(color: Colors.black)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.black54),
            ),
            body: SafeArea(
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: Form(
                  key: _formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      SizedBox(
                        height: 50,
                        width: size.width * 0.9,
                        child: TextFormField(
                          initialValue: snapshot.data!.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name Cannot be Empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Name",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                            contentPadding: const EdgeInsets.only(left: 12),
                            // enabledBorder: UnderlineInputBorder,
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onChanged: (val) {
                            // if (val == "") {
                            //   val = "New User";
                            // }
                            setState(() {
                              _currentName = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: size.width * 0.9,
                        child: TextFormField(
                          initialValue: snapshot.data!.phone,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Enter Name",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                            contentPadding: const EdgeInsets.only(left: 12),
                            // enabledBorder: UnderlineInputBorder,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black26),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onChanged: (val) {
                            // if (val == "") {
                            //   val = "New User";
                            // }
                            setState(() {
                              _currentName = val;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () async {
                          if (_currentName == "") {
                            _currentName = snapshot.data!.name;
                          }
                          await DatabaseService()
                              .updateUserName(_currentName)
                              .whenComplete(() {
                            showAnimatedDialogBox(
                                context,
                                "Updated Successfully",
                                () => Navigator.pop(context),
                                true,
                                3,
                                "6.png");
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                color: pinkColor,
                                borderRadius: BorderRadius.circular(32)),
                            child: const Center(child: Text("Update"))),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
