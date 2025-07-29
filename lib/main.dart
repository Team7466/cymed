import 'package:flutter/material.dart';
import 'add_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'İlaç Takip Uygulaması',
      debugShowCheckedModeBanner: false,
      home: const IlacEklemeEkrani(),
    );
  }
}