

import 'dart:math';

import 'package:flutter/material.dart';

class KarisikRenkler extends StatefulWidget {
  const KarisikRenkler({super.key});

  @override
  _KarisikRenklerState createState() => _KarisikRenklerState();
}

class _KarisikRenklerState extends State<KarisikRenkler> {
  final _random = Random();
  final List<Color> renkler = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.brown,
    Colors.black,
    Colors.white,
    Colors.grey
  ];

  final List<String> renkIsimleri = [
    'Kırmızı',
    'Yeşil',
    'Mavi',
    'Sarı',
    'Mor',
    'Turuncu',
    'Pembe',
    'Kahverengi',
    'Siyah',
    'Beyaz',
    'Gri'
  ];

  final List<int> renkIndeksleri = [];
  final List<TextEditingController> controllers = [];
  String mesaj = '';

  @override
  void initState() {
    super.initState();
    generateRenkIndeksleri();
  }

  void generateRenkIndeksleri() {
    renkIndeksleri.clear();
    controllers.clear();

    // Renk indekslerini karışık bir şekilde oluştur
    List<int> randomIndexes = List.generate(renkler.length, (index) => index);
    randomIndexes.shuffle();

    for (int i = 0; i < renkler.length; i++) {
      renkIndeksleri.add(randomIndexes[i]);
      controllers.add(TextEditingController());
    }
  }

  void dogrula() {
    setState(() {
      bool hepsiDogru = true;
      for (int i = 0; i < renkler.length; i++) {
        String normalizedInput = controllers[i].text.toLowerCase();
        if (normalizedInput != renkIsimleri[renkIndeksleri[i]].toLowerCase()) {
          hepsiDogru = false;
          break;
        }
      }
      mesaj = hepsiDogru ? 'Tüm cevaplar doğru!' : 'Bazı cevaplar yanlış, tekrar deneyin!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Karışık Renkler'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (int i = 0; i < renkler.length; i += 3)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int j = i; j < i + 3 && j < renkler.length; j++)
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  color: renkler[renkIndeksleri[j]],
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: controllers[j],
                                  decoration: const InputDecoration(labelText: 'Rengi girin'),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ElevatedButton(
              onPressed: dogrula,
              child: const Text('Onayla'),
            ),
            const SizedBox(height: 8),
            Text(
              mesaj,
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  generateRenkIndeksleri();
                });
              },
              child: const Text('Yeni Renkler'),
            ),
          ],
        ),
      ),
    );
  }
}
