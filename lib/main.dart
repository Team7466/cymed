import 'package:flutter/material.dart';
import 'info_screen.dart'; // Eğer dosya ismin buysa (lib/ilac_page.dart)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'cymed-1',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const IlacPage(
        medicienceName: "HAMETAN",
        expirationDate: "19/08/2025",
      ),
    );
  }
}
