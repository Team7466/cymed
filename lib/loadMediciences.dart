import 'dart:convert';
import 'dart:io';
import 'models/medicience.dart';

Future<List<Medicience>> loadingMediciences() async {
  //Dosyayı okuyoruz. Eğer dosyanın adı değişirse ya da dosya bulunmazsa burayı kontrol et
  final file = File("mediciences.json");

  //Dosya boşsa boş list dönderiyoruz.
  if (!await file.exists()) {
    return [];
  }

  final jsonString = await file.readAsString(); //dosyayı okuyoruz
  final List<dynamic> jsonList = jsonDecode(
    jsonString,
  ); //Json ı list olarak decode ediyoruz

  return jsonList
      .map((item) => Medicience.fromJson(item))
      .toList(); // Medicience data modeline uygun listeyi gönderiyoruz.
}
