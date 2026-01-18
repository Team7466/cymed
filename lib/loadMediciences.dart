import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'models/medicience.dart';

Future<List<Medicience>> loadingMediciences() async {
  try {
    String jsonString;
    
    // Web platformu için: rootBundle kullanıyoruz
    // Native platformlar için (Windows, Android, iOS, macOS, Linux) File kullanıyoruz
    if (kIsWeb) {
      // Web platformunda
      jsonString = await rootBundle.loadString('mediciences.json');
    } else {
      // Native platformlar
      final file = File("mediciences.json");
      if (!await file.exists()) {
        return [];
      }
      jsonString = await file.readAsString();
    }

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .map((item) => Medicience.fromJson(item))
        .toList();
  } catch (e) {
    print('Hata: Mediciences yükleme başarısız: $e');
    return [];
  }
}
