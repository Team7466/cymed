import 'package:cymed/add_screen.dart';
import 'package:cymed/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';
import 'models/medicience.dart';
import 'loadMediciences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  //Stateful Widget, Türkçeye çevirirsek durum alabilen Widget olarak çevirebiliriz
  //Bu bizim sayfada olan değişiklikleri sayfayı yenilemeden yapmamızı sağlar.
  //Bu widget kullanıcıdan veri aldığımız ekranlar için kullanılır.
  //Bu sayfada veri alacağımız kısım arama kutusudur.
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //Tamamen örnek olarak burada bir liste atayıp oradan ilaçların isimlerini çekiyoruz.
  //Daha sonrasında veri tabanınından alacağız bu verileri.

  List<Medicience> mediciences = [];

  String searchTerm = "";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final loadedData =
        await loadingMediciences(); //dosyaları okuma ve değişkene atama
    setState(() {
      mediciences = loadedData; //verileri liste atıyoruz.
    });
  }

  @override
  Widget build(BuildContext context) {
    final lowerSearch = searchTerm.toLowerCase();

    final exactMatches = mediciences.where((medicience) {
      return medicience.name.toLowerCase() == lowerSearch;
    }).toList(); //Aynı eşleşme olanları listeleme yapıyor

    final similarMatches = mediciences
        .where(
          (medicience) =>
              medicience.name.toLowerCase() !=
                  lowerSearch //eşlesenleri alma
                  &&
              (medicience.name.toLowerCase().contains(lowerSearch) ||
                  medicience.name.toLowerCase().similarityTo(lowerSearch) >
                      0.3),
        )
        .toList();
    //benzerlik oranına göre sıralama
    similarMatches.sort(
      (a, b) => b.name
          .toLowerCase()
          .similarityTo(lowerSearch)
          .compareTo(a.name.similarityTo(lowerSearch)),
    );
    final filteredMediciences = [
      ...exactMatches,
      ...similarMatches,
    ]; //iki farklı listeyi birleştir.

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Mediciences"),
      ), //Sayfanın en üstüne görünen kısım.
      body: mediciences.isEmpty
          ? const Center(child: CircularProgressIndicator()) //yükleme ekranı
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

                      const SizedBox(
                        width: 8,
                      ), //arama kutusu ile buton arası boşluk
                      //İlaç ekleme butonu
                      IconButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IlacEklemeEkrani(),
                            ), //Navigator true dönerse mainScreen ve listeyi yenileyeceğiz.
                          );
                          if (result == true) {
                            _loadData();
                          }
                        },
                        icon: Icon(Icons.add),
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
                      return Padding(
                        //Burada ilaçların isminin yazdığı text ile genel ilaçların olduğu kutunun
                        //arasındaki boşluğu belirşiyoruz.
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        child: Card(
                          //İlaçların isimlerine dikdörtgensi bir görünüm veriyoruz.
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: ListTile(
                            title: Text(filteredMediciences[index].name),
                            subtitle: Text(
                              "SKT: ${filteredMediciences[index].expirationDate}",
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => InfoScreen(
                                    medicienceName:
                                        filteredMediciences[index].name,
                                    expirationDate: filteredMediciences[index]
                                        .expirationDate,
                                  ),
                                ),
                              );
                              // Üstteki kod satırı diğer dosyalarla birleştirildiğinde açılacak
                            },
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
