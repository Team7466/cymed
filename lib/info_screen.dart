import 'package:flutter/material.dart';

class IlacPage extends StatelessWidget {
  const IlacPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İlaç Bilgileri'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Başlığı ortaladıke
            Center(
              child: const Text(
                'İlaç Başligi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Girilebilir son kullanma tarihi
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Son kullanma tarihi',
                hintText: 'DD/MM/YYYY',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
                filled: true,
                fillColor: Colors.amber[100],
              ),
              keyboardType: TextInputType.datetime,
            ),

            const Spacer(),

            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 224, 226),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueGrey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Geri',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'İlaç bilgileri',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
