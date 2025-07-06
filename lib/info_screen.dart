import 'package:flutter/material.dart';

class IlacPage extends StatelessWidget {
  const IlacPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text('İlaç Bilgileri'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // İlaç başlığı ve son kullanma tarihi aynı satırda
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'İlaç Başlığı',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'DD/MM/YYYY',
                      labelText: 'SKT',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(19),
                      ),
                      filled: true,
                      fillColor: Colors.amber[100],
                    ),
                    keyboardType: TextInputType.datetime,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32), // Araya biraz boşluk

            // Daha yukarı ve büyük "İlaç bilgileri" kutusu
            Container(
              width: double.infinity,
              height: 280, // Eskiden 200'dü, şimdi daha büyük
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 224, 226),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueGrey),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
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
