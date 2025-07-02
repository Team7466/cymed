import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> mediciences = ["Example1", "Example2"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mediciences")),
      body: ListView.builder(
        itemCount: mediciences.length,
        itemBuilder: (context, index) =>
            ListTile(title: Text(mediciences[index])),
      ),
    );
  }
}
