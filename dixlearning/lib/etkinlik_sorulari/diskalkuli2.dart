import 'package:flutter/material.dart';


class CikarmaSayfasi extends StatefulWidget {
  const CikarmaSayfasi({super.key});

  @override
  _CikarmaSayfasiState createState() => _CikarmaSayfasiState();
}

class _CikarmaSayfasiState extends State<CikarmaSayfasi> {
  final List<List<int>> sorular = [
    [9, 2],
    [7, 3],
    [10, 5],
    [8, 6],
  ];

  late List<int> dogruCevaplar;
  List<TextEditingController> cevapKontrolleri = [];
  List<TextEditingController> sonucKontrolleri = [];
  List<bool> cevapDogruMu = [];
  List<bool> sonucDogruMu = [];

  @override
  void initState() {
    super.initState();
    dogruCevaplar = sorular.map((soru) => soru[0] - soru[1]).toList();
    dogruCevaplar.sort((a, b) => a.compareTo(b));
    cevapKontrolleri = List.generate(sorular.length, (index) => TextEditingController());
    sonucKontrolleri = List.generate(dogruCevaplar.length, (index) => TextEditingController());
    cevapDogruMu = List.filled(sorular.length, true);
    sonucDogruMu = List.filled(dogruCevaplar.length, true);
  }

  void kontrolEt() {
    bool dogruMu = true;
    List<bool> yeniCevapDogruMu = List.filled(sorular.length, true);
    List<bool> yeniSonucDogruMu = List.filled(dogruCevaplar.length, true);

    // Sonuçların doğru olup olmadığını kontrol et
    for (int i = 0; i < sorular.length; i++) {
      if (int.tryParse(cevapKontrolleri[i].text) != sorular[i][0] - sorular[i][1]) {
        dogruMu = false;
        yeniCevapDogruMu[i] = false;
      }
    }

    // Sıralamanın doğru olup olmadığını kontrol et
    List<int> kullaniciCevaplari = sonucKontrolleri.map((controller) => int.tryParse(controller.text) ?? 0).toList();
    List<int> dogruSiraliCevaplar = List.from(dogruCevaplar);
    dogruSiraliCevaplar.sort((a, b) => a.compareTo(b));

    for (int i = 0; i < dogruSiraliCevaplar.length; i++) {
      if (kullaniciCevaplari[i] != dogruSiraliCevaplar[i]) {
        dogruMu = false;
        yeniSonucDogruMu[i] = false;
      }
    }

    setState(() {
      cevapDogruMu = yeniCevapDogruMu;
      sonucDogruMu = yeniSonucDogruMu;
    });

    if (dogruMu) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Tebrikler!'),
            content: Text('Sonuçlar doğru sıralandı!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Yanlış!'),
            content: Text('Lütfen tekrar deneyin.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Çıkarma Etkinliği'),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: kontrolEt,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.green[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(sorular.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Text(
                        '${sorular[index][0]} - ${sorular[index][1]} = ',
                        style: TextStyle(fontSize: 24, color: Colors.indigo),
                      ),
                      Expanded(
                        child: TextField(
                          controller: cevapKontrolleri[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24, color: Colors.indigo),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '',
                            errorText: cevapDogruMu[index] ? null : 'Yanlış',
                            errorBorder: cevapDogruMu[index]
                                ? null
                                : OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 20),
              Text(
                'Sonuçları küçükten büyüğe sıralayınız:',
                style: TextStyle(fontSize: 20, color: Colors.indigo),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(dogruCevaplar.length * 2 - 1, (index) {
                  if (index % 2 == 0) {
                    int textFieldIndex = index ~/ 2;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: TextField(
                          controller: sonucKontrolleri[textFieldIndex],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24, color: Colors.indigo),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '',
                            errorText: sonucDogruMu[textFieldIndex] ? null : 'Yanlış',
                            errorBorder: sonucDogruMu[textFieldIndex]
                                ? null
                                : OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Text(
                      ' < ',
                      style: TextStyle(fontSize: 24, color: Colors.indigo),
                    );
                  }
                }),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: kontrolEt,
                  child: Text('Kontrol Et'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.lightBlueAccent,
                    textStyle: TextStyle(fontSize: 20),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
