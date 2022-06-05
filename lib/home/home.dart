import 'package:flutter/material.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'home',
      home: Container(
        color: Colors.white,
        width: 400,
        height: 400,
        child: Center(
          child: Text('Wel Come',
          textAlign: TextAlign.center,
          ),
        ),
      
      ),
      
    );
    
  }
}