import 'package:flutter/material.dart';
import 'models/medicience.dart';

class InfoScreen extends StatelessWidget {
  final Medicience medicience;

  const InfoScreen({super.key, required this.medicience});

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // İlaç başlığı
              Text(
                medicience.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // İlaç alma saati
              _buildInfoRow(
                icon: Icons.access_time,
                label: 'İlaç Alma Saati',
                value: medicience.takingTime,
              ),
              const SizedBox(height: 16),

              // Sıklık
              _buildInfoRow(
                icon: Icons.repeat,
                label: 'Sıklık',
                value: medicience.frequency,
              ),
              const SizedBox(height: 16),

              // Kullanım süresi
              _buildInfoRow(
                icon: Icons.calendar_today,
                label: 'Kullanım Süresi',
                value: medicience.duration,
              ),
              const SizedBox(height: 32),

              // Notlar başlığı
              const Text(
                'Notlar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              // Notlar kutusu
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber[200]!, width: 1.5),
                ),
                child: Text(
                  medicience.notes.isEmpty
                      ? 'Herhangi bir not bulunmamaktadır'
                      : medicience.notes,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Colors.blue),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
