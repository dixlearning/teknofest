import 'package:flutter/material.dart';

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
  final List<String> mevsimler = ['İlkbahar', 'Yaz', 'Sonbahar', 'Kış'];
  final Map<String, String> dogruEslestirme = {
    'İlkbahar': '🌸',
    'Yaz': '🍦',
    'Sonbahar': '🍂',
    'Kış': '🧣',
  };

  String secilenMevsim = '';
  String secilenGorsel = '';
  final Map<String, Color> mevsimRenkleri = {};
  final Map<String, Color> gorselRenkleri = {};
  final Set<String> dogruEslestirilenler = {}; // Doğru eşleşen mevsimlerin seti

  void _onMevsimTapped(String mevsim) {
    if (!dogruEslestirilenler.contains(mevsim)) {
      // Eğer mevsim doğru eşleşmemişse işlem yapılabilir
      setState(() {
        secilenMevsim = mevsim;
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
        title: const Text('Mevsim Eşleme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mevsimleri uygun resimlerle eşleyiniz.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Sol kısım (Mevsimler)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: mevsimler.map((mevsim) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 24.0),
                          child: GestureDetector(
                            onTap: () => _onMevsimTapped(mevsim),
                            child: Text(
                              mevsim,
                              style: TextStyle(
                                fontSize: 24,
                                color: mevsimRenkleri.containsKey(mevsim)
                                    ? mevsimRenkleri[mevsim]
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  // Sağ kısım (Görseller)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: dogruEslestirme.values.map((gorsel) {
                        return _buildGorsel(gorsel);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGorsel(String gorsel) {
    return GestureDetector(
      onTap: () => _onGorselTapped(gorsel),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: gorselRenkleri.containsKey(gorsel)
              ? gorselRenkleri[gorsel]
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          gorsel,
          style: const TextStyle(
            fontSize: 48,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
