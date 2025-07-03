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
  List<String> mediciences = ["Example1", "Example2"];

  String searchTerm = "";

  @override
  Widget build(BuildContext context) {
    // if (searchTerm.isEmpty) {
    //   final List<String> filteredMediciences = mediciences;
    // } else {
    //   final List<String> filteredMediciences = mediciences
    //       .where((medicience) => medicience.similarityTo(searchTerm) > 0.5)
    //       .toList();
    // }
    final List<String> filteredMediciences = mediciences.where((medicience) {
      final lowerMedicience = medicience.toLowerCase();
      final lowerSearch = searchTerm.toLowerCase();
      return lowerMedicience.contains(lowerSearch) ||
          lowerMedicience.similarityTo(lowerSearch) > 0.5;
    }).toList();

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
