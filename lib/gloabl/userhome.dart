import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(

        // appBar: AppBar(title: Text("User Home welcome")),
        body: Center(
      child: Text("Userhome"),
    ));
  }
}
