import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'models/medicience.dart';

Future<List<Medicience>> loadingMediciences() async {
  try {
    String jsonString;

    // Different loading strategies for web vs native platforms
    if (kIsWeb) {
      // Web: load from bundled assets
      jsonString = await rootBundle.loadString('mediciences.json');
    } else {
      // Native platforms: load from local file
      final file = File("mediciences.json");
      if (!await file.exists()) {
        return [];
      }
      jsonString = await file.readAsString();
    }

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => Medicience.fromJson(item)).toList();
  } catch (e) {
    print('Hata: Mediciences yükleme başarısız: $e');
    return [];
  }
}

// Save medicines to JSON file (native platforms only)
Future<bool> saveMediciences(List<Medicience> mediciences) async {
  try {
    final jsonString = jsonEncode(
      mediciences.map((med) => med.toJson()).toList(),
    );

    if (kIsWeb) {
      // Web platformunda kaydetme desteklenmiyor (localStorage kullanılabilir)
      print('Uyarı: Web platformunda yerel dosya kaydı desteklenmiyor');
      return false;
    } else {
      // Native platformlar
      final file = File("mediciences.json");
      await file.writeAsString(jsonString);
      print('İlaçlar başarıyla kaydedildi');
      return true;
    }
  } catch (e) {
    print('Hata: İlaçlar kaydedilirken hata oluştu: $e');
    return false;
  }
}
