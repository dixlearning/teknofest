import 'package:flutter/material.dart';
import 'dart:math';

class KarisikAylar extends StatefulWidget {
  const KarisikAylar({super.key});

  @override
  _KarisikAylarState createState() => _KarisikAylarState();
}

class _KarisikAylarState extends State<KarisikAylar> {
  final _random = Random();
  final List<String> aylar = [
    'OCAK',
    'ŞUBAT',
    'MART',
    'NİSAN',
    'MAYIS',
    'HAZİRAN',
    'TEMMUZ',
    'AĞUSTOS',
    'EYLÜL',
    'EKİM',
    'KASIM',
    'ARALIK'
  ];

  List<String> karisikAylar = [];
  final List<TextEditingController> controllers = [];
  String mesaj = '';
  bool hataVarMi = false;

  @override
  void initState() {
    super.initState();
    generateKarisikAylar();
  }

  void generateKarisikAylar() {
    aylar.shuffle(); // Ayların sırasını karıştır
    karisikAylar.clear();
    controllers.clear();
    for (var ay in aylar) {
      final harfler = ay.split('')..shuffle();
      karisikAylar.add(harfler.join(''));
      controllers.add(TextEditingController());
    }
  }

  void dogrula() {
    setState(() {
      bool hepsiDogru = true;
      for (int i = 0; i < aylar.length; i++) {
        String normalizedInput = controllers[i].text.toLowerCase();
        if (normalizedInput != aylar[i].toLowerCase()) {
          hepsiDogru = false;
          break;
        }
      }
      if (hepsiDogru) {
        mesaj = 'Tüm cevaplar doğru!';
        hataVarMi = false;
      } else {
        mesaj = 'Bazı cevaplar yanlış, tekrar deneyin!';
        hataVarMi = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayları Düzenleyelim!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Harfleri karışık olarak verilen ayları doğru bir şekilde yazalım!',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Comic Sans MS'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16), // Başlık altına boşluk ekleyelim
            Expanded(
              child: ListView.builder(
                itemCount: aylar.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors
                                .primaries[index % Colors.primaries.length]
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            karisikAylar[index],
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Comic Sans MS'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: controllers[index],
                          decoration: InputDecoration(
                            labelText: 'Ayı girin',
                            labelStyle: const TextStyle(color: Colors.purple),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorText: hataVarMi &&
                                    controllers[index].text.toLowerCase() !=
                                        aylar[index].toLowerCase()
                                ? 'Yanlış giriş, tekrar deneyin'
                                : null,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: dogrula,
              child: const Text('Onayla',
                  style: TextStyle(fontSize: 18, fontFamily: 'Comic Sans MS')),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              mesaj,
              style: TextStyle(
                  fontSize: 20,
                  color: hataVarMi ? Colors.red : Colors.green,
                  fontFamily: 'Comic Sans MS'),
            ),
          ],
        ),
      ),
    );
  }
}
