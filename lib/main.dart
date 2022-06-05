import 'package:flutter/material.dart';
import 'package:splash_screen/splashpage/splashscreen.dart';

void main() {
  runApp(const Miesitu());
}

class Miesitu extends StatelessWidget {
  const Miesitu({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
