import 'dart:async';

import 'package:flutter/material.dart';
import 'package:splash_screen/home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Color.fromARGB(255, 90, 112, 144),
                  Color.fromARGB(255, 18, 30, 30)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                color: Color.fromARGB(255, 251, 255, 255),
              ),
            ),
          ),
          Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 75.0,
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: 110.0,
                      width: 110.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                
                  SizedBox(
                    height: 30,
                  ),
                  CircularProgressIndicator(
                    color: Color.fromARGB(255, 44, 41, 33),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
