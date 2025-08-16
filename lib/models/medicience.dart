//Burada datayı tutmak için bir model yazıyorum
//model programlamada verilerin depolanması, yazdırılması, kullanılması için bir
//klavuz gibi bir şey.
class Medicience {
  final String name;
  final String expirationDate;

  Medicience({required this.name, required this.expirationDate});

  //Veri modeli
  Map<String, dynamic> toJson() => {
    'medicienceName': name,
    'expirationDate': expirationDate,
  };

  //Jsondan gelen dosyayı okumak için
  factory Medicience.fromJson(Map<String, dynamic> json) => Medicience(
    name: json['medicienceName'],
    expirationDate: json['expirationDate'],
  );
}
