import 'package:flutter/material.dart';

void main() => runApp(Miesitu());

class Miesitu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("MIESITU"),
        ),
        body: const Center(
          child: Text("Miesitu"),
        ),
      ),
    );
  }
}
