import 'package:flutter/material.dart';
import 'dart:math';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MevsimEslestirmeScreen(),
    );
  }
}

class MevsimEslestirmeScreen extends StatefulWidget {
  @override
  _MevsimEslestirmeScreenState createState() => _MevsimEslestirmeScreenState();
}

class _MevsimEslestirmeScreenState extends State<MevsimEslestirmeScreen> {
  final List<String> mevsimler = [
    'Kış',
    'Sonbahar',
    'İlkbahar',
    'Yaz'
  ]; // İstenilen sıralama
  final Map<String, String> dogruEslestirme = {
    'İlkbahar': '🌸',
    'Yaz': '🍦',
    'Sonbahar': '🍂',
    'Kış': '🧣',
  };

  List<String> karisikGorseller = [];

  String secilenMevsim = '';
  String secilenGorsel = '';
  final Map<String, Color> mevsimRenkleri = {};
  final Map<String, Color> gorselRenkleri = {};
  final Set<String> dogruEslestirilenler = {}; // Doğru eşleşen mevsimlerin seti

  @override
  void initState() {
    super.initState();
    karisikGorseller = dogruEslestirme.values.toList();
    karisikGorseller.shuffle(Random()); // Emojileri karıştır
  }

  void _onMevsimTapped(String mevsim) {
    if (!dogruEslestirilenler.contains(mevsim)) {
      // Eğer mevsim doğru eşleşmemişse işlem yapılabilir
      setState(() {
        secilenMevsim = mevsim;
        mevsimRenkleri[mevsim] = Colors.blue; // Tıklanınca renk değişikliği
        _kontrolEt();
      });
    }
  }

  void _onGorselTapped(String gorsel) {
    if (!gorselRenkleri.containsKey(gorsel) ||
        gorselRenkleri[gorsel] != Colors.green) {
      // Eğer görsel doğru eşleşmemişse işlem yapılabilir
      setState(() {
        secilenGorsel = gorsel;
        gorselRenkleri[gorsel] = Colors.blue; // Tıklanınca renk değişikliği
        _kontrolEt();
      });
    }
  }

  void _kontrolEt() {
    if (secilenMevsim.isNotEmpty && secilenGorsel.isNotEmpty) {
      if (dogruEslestirme[secilenMevsim] == secilenGorsel) {
        // Doğru eşleşme -> Yeşil renk ve değiştirilemez hale getir
        mevsimRenkleri[secilenMevsim] = Colors.green;
        gorselRenkleri[secilenGorsel] = Colors.green;
        dogruEslestirilenler
            .add(secilenMevsim); // Doğru eşleşen mevsimi set'e ekle
      } else {
        // Yanlış eşleşme -> Kırmızı renk (Sadece tıklanan mevsim ve görsel)
        mevsimRenkleri[secilenMevsim] = Colors.red;
        gorselRenkleri[secilenGorsel] = Colors.red;
      }
      // Seçimleri sıfırla
      secilenMevsim = '';
      secilenGorsel = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mevsimler!'),
        backgroundColor: Colors.teal, // AppBar rengi
      ),
      body: Container(
        color: Colors.grey[200], // Arka plan rengi
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Mevsim adlarını, karşılarında bulunan resimler ile doğru bir şekilde eşleyelim.',
                textAlign: TextAlign.justify, // Text justify konumu
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.teal), // Başlık stili
              ),
            ),
            SizedBox(height: 16), // Başlık ile mevsimler arasında boşluk
            Expanded(
              child: ListView.builder(
                itemCount: mevsimler.length,
                itemBuilder: (context, index) {
                  String mevsim = mevsimler[index];
                  String gorsel = karisikGorseller[index];

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Mevsim adı
                      GestureDetector(
                        onTap: () => _onMevsimTapped(mevsim),
                        child: Container(
                          width: 150, // Mevsim text box boyutu
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            mevsim,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              color: mevsimRenkleri.containsKey(mevsim)
                                  ? mevsimRenkleri[mevsim]
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 50), // Mevsim ve görsel arasında boşluk
                      // Görsel
                      GestureDetector(
                        onTap: () => _onGorselTapped(gorsel),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: gorselRenkleri.containsKey(gorsel)
                                ? gorselRenkleri[gorsel]
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            gorsel,
                            style: TextStyle(
                              fontSize: 36,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
