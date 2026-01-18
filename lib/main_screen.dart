import 'package:cymed/add_screen.dart';
import 'package:cymed/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';
import 'models/medicience.dart';
import 'loadMediciences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Medicience> mediciences = [];
  String searchTerm = "";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final loadedData = await loadingMediciences();
    setState(() {
      mediciences = loadedData;
    });
  }

  // Delete medicine with confirmation dialog
  Future<void> _deleteMedicine(int index) async {
    final confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('İlaçı Sil'),
        content: Text('${mediciences[index].name} silinecek. Devam et?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sil'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        mediciences.removeAt(index);
      });
      // Save updated list to JSON file
      await saveMediciences(mediciences);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('İlaç silindi')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final lowerSearch = searchTerm.toLowerCase();

    // Separate exact matches from similar matches for better search results
    final exactMatches = mediciences.where((medicience) {
      return medicience.name.toLowerCase() == lowerSearch;
    }).toList();

    // Find medicines with partial or similar names
    final similarMatches = mediciences
        .where(
          (medicience) =>
              medicience.name.toLowerCase() != lowerSearch &&
              (medicience.name.toLowerCase().contains(lowerSearch) ||
                  medicience.name.toLowerCase().similarityTo(lowerSearch) >
                      0.3),
        )
        .toList();

    similarMatches.sort(
      (a, b) => b.name
          .toLowerCase()
          .similarityTo(lowerSearch)
          .compareTo(a.name.similarityTo(lowerSearch)),
    );

    final filteredMediciences = [...exactMatches, ...similarMatches];

    return Scaffold(
      appBar: AppBar(title: const Text("My Mediciences")),
      body: mediciences.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: "Search a medicience",
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchTerm = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IlacEklemeEkrani(),
                            ),
                          );
                          if (result == true) {
                            _loadData();
                          }
                        },
                        icon: const Icon(Icons.add),
                        color: Colors.black,
                        tooltip: "İlaç Ekle",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredMediciences.length,
                    itemBuilder: (context, index) {
                      final medicine = filteredMediciences[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: ListTile(
                            title: Text(medicine.name),
                            subtitle: Text(
                              "Saat: ${medicine.takingTime} | Sıklık: ${medicine.frequency}",
                            ),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.info_outline),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              InfoScreen(medicience: medicine),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _deleteMedicine(
                                      mediciences.indexOf(medicine),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
