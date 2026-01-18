// Data model for medicine information
class Medicience {
  final String name;
  final String takingTime; // İlacı alma saati (HH:MM formatında)
  final String frequency; // Ne kadar sıklıkta alınacak (Günde 1, Günde 2 vb)
  final String duration; // Ne kadar süre kullanılacak
  final String notes; // Kullanıcı notları

  Medicience({
    required this.name,
    required this.takingTime,
    required this.frequency,
    required this.duration,
    required this.notes,
  });

  // Convert medicine object to JSON format for file storage
  Map<String, dynamic> toJson() => {
    'medicienceName': name,
    'takingTime': takingTime,
    'frequency': frequency,
    'duration': duration,
    'notes': notes,
  };

  // Create medicine object from JSON data
  factory Medicience.fromJson(Map<String, dynamic> json) => Medicience(
    name: json['medicienceName'],
    takingTime: json['takingTime'] ?? '',
    frequency: json['frequency'] ?? '',
    duration: json['duration'] ?? '',
    notes: json['notes'] ?? '',
  );
}
