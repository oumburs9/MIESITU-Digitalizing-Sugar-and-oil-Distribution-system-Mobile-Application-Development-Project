import 'package:flutter/material.dart';

void main() {
  runApp(const Miesitu());
}

class Miesitu extends StatelessWidget {
  const Miesitu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MIESITU"),
      ),
      body: const Center(
        child: Text("Miesitu"),
      ),
    );
  }
}
