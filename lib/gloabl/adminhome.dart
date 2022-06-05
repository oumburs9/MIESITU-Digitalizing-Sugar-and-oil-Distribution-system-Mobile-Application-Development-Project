import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:labpract/gloabl/admin_profile.dart';
import 'package:labpract/gloabl/route_name_constants.dart';
// import 'package:labpract/presentation/products/screens/announcement_admin.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);
  @override
  State<AdminHome> createState() => AdminHomeState();
}

class AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Admin Home")),
      body: ListView(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                context.goNamed(adminProductList);
                // GoRouter.of(context).pushNamed('/addproduct');
              },
              child: const Text("productList"),
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedInd = 0;

  // static const List<Widget> _widgetOptions = <Widget>[
  //   AdminAnnounce(),
  //   AdminProduct(),
  //   AdminProfile()
  // ];

  void handleTab(int index) {
    setState(() {
      _selectedInd = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.announcement,
          ),
          label: 'Announcement',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Products',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedInd,
      onTap: handleTab,
    );
  }
}
