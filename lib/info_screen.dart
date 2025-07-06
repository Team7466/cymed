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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
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
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueGrey),
              ),
              child: const Center(
                child: Text(
                  'İlaç bilgileri',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
