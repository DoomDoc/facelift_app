// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:facelift_constructions/constants.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class AccountsScreen extends StatefulWidget {
  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  // AuthClass authClass = AuthClass();
  final _formKey = GlobalKey<FormState>();
  String _currentName = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<Uuser>(
      stream: DatabaseService().userDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      TextFormField(
                        initialValue: snapshot.data!.name,
                        validator: (val) => val == null
                            ? "Please Enter a Name"
                            : val.isEmpty
                                ? "Please Enter a Name"
                                : null,
                        onChanged: (val) => setState(() => _currentName = val),
                      ),
                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await DatabaseService()
                                .updateUserName(_currentName);
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(color: pinkColor),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
