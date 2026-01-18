import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'models/medicience.dart';
import 'loadMediciences.dart';

class IlacEklemeEkrani extends StatefulWidget {
  const IlacEklemeEkrani({super.key});

  @override
  State<IlacEklemeEkrani> createState() => _IlacEklemeEkraniState();
}

class _IlacEklemeEkraniState extends State<IlacEklemeEkrani> {
  final TextEditingController ilacAdiController = TextEditingController();
  final TextEditingController takingTimeController = TextEditingController();
  final TextEditingController frequencyController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // Save new medicine to JSON file
  void ilaciKaydet() async {
    String ad = ilacAdiController.text.trim();
    String takingTime = takingTimeController.text.trim();
    String frequency = frequencyController.text.trim();
    String duration = durationController.text.trim();
    String notes = notesController.text.trim();

    // Validate all required fields are filled
    if (ad.isEmpty ||
        takingTime.isEmpty ||
        frequency.isEmpty ||
        duration.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen tüm alanları doldurun')),
      );
      return;
    }

    String edittedName = ad.toUpperCase();

    // Create new medicine object with user inputs
    Medicience newMedicine = Medicience(
      name: edittedName,
      takingTime: takingTime,
      frequency: frequency,
      duration: duration,
      notes: notes,
    );

    // Load existing medicines and add the new one
    final loadedMedicines = await loadingMediciences();
    final allMedicines = [...loadedMedicines, newMedicine];

    // Save updated list to file
    await saveMediciences(allMedicines);

    Navigator.pop(context, true);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('İlaç başarıyla kaydedildi')));

    ilacAdiController.clear();
    takingTimeController.clear();
    frequencyController.clear();
    durationController.clear();
    notesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder maviBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.blue),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('İlaç Ekleme'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // İlaç adı
              TextField(
                controller: ilacAdiController,
                decoration: InputDecoration(
                  labelText: 'İlaç Adı',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: maviBorder,
                  focusedBorder: maviBorder.copyWith(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // İlaç alma saati
              TextField(
                controller: takingTimeController,
                decoration: InputDecoration(
                  labelText: 'İlaç Alma Saati (HH:MM)',
                  hintText: '09:30',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: maviBorder,
                  focusedBorder: maviBorder.copyWith(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sıklık
              TextField(
                controller: frequencyController,
                decoration: InputDecoration(
                  labelText: 'Sıklık (ör: Günde 2, Haftada 1 vb)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: maviBorder,
                  focusedBorder: maviBorder.copyWith(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Kullanım süresi
              TextField(
                controller: durationController,
                decoration: InputDecoration(
                  labelText: 'Kullanım Süresi (ör: 10 gün, 3 ay vb)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: maviBorder,
                  focusedBorder: maviBorder.copyWith(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Notlar
              TextField(
                controller: notesController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Notlar (Yemek öncesi/sonrası, yan etki vb)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: maviBorder,
                  focusedBorder: maviBorder.copyWith(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Kaydet butonu
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('İlaç Ekle'),
                  onPressed: ilaciKaydet,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    ilacAdiController.dispose();
    takingTimeController.dispose();
    frequencyController.dispose();
    durationController.dispose();
    notesController.dispose();
    super.dispose();
  }
}
