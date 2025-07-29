import 'package:flutter/material.dart';

class IlacEklemeEkrani extends StatefulWidget {
  const IlacEklemeEkrani({super.key});

  @override
  State<IlacEklemeEkrani> createState() => _IlacEklemeEkraniState();
}

class _IlacEklemeEkraniState extends State<IlacEklemeEkrani> {
  final TextEditingController ilacAdiController = TextEditingController();
  final TextEditingController tarihController = TextEditingController();
  String ilacBilgisi = '';

  void ilaciKaydet() {
    String ad = ilacAdiController.text.trim();
    String tarih = tarihController.text.trim();

    if (ad.isEmpty || tarih.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen tüm alanları doldurun')),
      );
      return;
    }

    debugPrint('İlaç adı: $ad');
    debugPrint('Son kullanma tarihi: $tarih');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('İlaç başarıyla kaydedildi')),
    );

    ilacAdiController.clear();
    tarihController.clear();
    setState(() {
      ilacBilgisi = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder maviBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Colors.blue),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('İlaç Ekleme'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: ilacAdiController,
decoration:  InputDecoration(
                labelText: 'İlaç Adı',
                border: OutlineInputBorder(),
                enabledBorder: maviBorder,
                focusedBorder: maviBorder.copyWith(
                  borderSide:  BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 64),
            TextField(
              controller: tarihController,
              decoration:  InputDecoration(
                labelText: 'Son Kullanma Tarihi',
                border: OutlineInputBorder(),
                hintText: 'GG/AA/YYYY',
                                enabledBorder: maviBorder,
                focusedBorder: maviBorder.copyWith(
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 64),
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: Text(
                ilacBilgisi.isEmpty
                    ? 'İlaç bilgisi burada gösterilecek (şimdilik boş)'
                    : ilacBilgisi,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('İlaç Ekle'),
                onPressed: ilaciKaydet,
              ),
            ),
          ],
        ),
      ),
    );
  }
}