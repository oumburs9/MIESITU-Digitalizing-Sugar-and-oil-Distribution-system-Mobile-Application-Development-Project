import 'package:flutter/material.dart';
import 'package:miesitu/gloabl/adminhome.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AdminProfile"),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
