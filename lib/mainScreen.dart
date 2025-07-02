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
      appBar: AppBar(title: const Text("My Mediciences")),
      body: ListView.builder(
        itemCount: mediciences.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 6.0,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: ListTile(
                title: Text(mediciences[index]),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> const medicienceInfo))
                  // Üstteki kod satırı diğer dosyalarla birleştirildiğinde açılacak
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
