import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';

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
  List<String> mediciences = [
    "Example1",
    "Example2",
    "Example1",
    "Example 3",
    "Example 2",
  ];

  String searchTerm = "";

  @override
  Widget build(BuildContext context) {
    final lowerSearch = searchTerm.toLowerCase();

    final exactMatches = mediciences.where((medicience) {
      return medicience.toLowerCase() == lowerSearch;
    }).toList(); //Aynı eşleşme olanları listeleme yapıyor

    final similarMatches = mediciences
        .where(
          (medicience) =>
              medicience.toLowerCase() !=
                  lowerSearch //eşlesenleri alma
                  &&
              (medicience.toLowerCase().contains(lowerSearch) ||
                  medicience.toLowerCase().similarityTo(lowerSearch) > 0.3),
        )
        .toList();
    //benzerlik oranına göre sıralama
    similarMatches.sort(
      (a, b) => b
          .toLowerCase()
          .similarityTo(lowerSearch)
          .compareTo(a.similarityTo(lowerSearch)),
    );
    final filteredMediciences = [
      ...exactMatches,
      ...similarMatches,
    ]; //iki farklı listeyi birleştir.

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Mediciences"),
      ), //Sayfanın en üstüne görünen kısım.
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
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
                      title: Text(filteredMediciences[index]),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> const medicienceInfo))
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
