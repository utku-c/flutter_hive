// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedView extends StatefulWidget {
  SharedView({Key? key}) : super(key: key);

  @override
  State<SharedView> createState() => _SharedViewState();
}

class _SharedViewState extends State<SharedView> {
  late SharedPreferences preferences;
  String data = "xx";
  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  Future<void> getLocalData() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Icon(
              Icons.android,
              size: 100,
              color: Colors.green,
            ),
            Text(data),
            TextButton(
              onPressed: () {
                setState(() {
                  data = preferences.getString("key")!;
                });
                preferences.remove("key");
              },
              child: Text(
                "GET Shared DATA",
                style: TextStyle(color: Colors.amber),
              ),
            ),
            TextButton(
              onPressed: () {
                preferences.setString("key", "UTKU");
              },
              child: Text(
                "SAVE Shared DATA",
                style: TextStyle(color: Colors.red),
              ),
            ),
            SelectableText("kopyalamak için tıkla"),
          ],
        ),
      ),
    );
  }
}
