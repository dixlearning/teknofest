import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> words = [
    '',
    'bitki',
    'börek',
    'değirmen',
    'peynir',
    'dünya',
    'boncuk',
    'papatya',
    'bardak',
    'baston',
    'balon',
    'palto',
    'bilye',
    'pamuk',
    'defter',
    'priz',
    'başlık',
    'bütün',
    'balık',
    ''
  ];

  final List<bool> isCorrect = List<bool>.filled(20, false);
  final List<bool> isWrong = List<bool>.filled(20, false);
  final List<bool> isNext = List<bool>.filled(20, false);
  int currentIndex = 1; // Başlangıçta sadece bitki seçilebilir

  @override
  void initState() {
    super.initState();
    _highlightNextWords(
        start: true); // Oyunun başlangıcında sadece "bitki" seçilebilir
  }

  void _highlightNextWords({bool start = false}) {
    setState(() {
      for (int i = 0; i < words.length; i++) {
        isNext[i] = false;
      }

      // Başlangıçta sadece bitki seçilebilir
      if (start) {
        isNext[currentIndex] = true;
      } else {
        isNext[currentIndex] = true;

        if (currentIndex % 4 != 0) isNext[currentIndex - 1] = true;
        if (currentIndex % 4 != 3) isNext[currentIndex + 1] = true;
        if (currentIndex >= 4) isNext[currentIndex - 4] = true;
        if (currentIndex < 16) isNext[currentIndex + 4] = true;
      }
    });
  }

  void _resetGame() {
    setState(() {
      for (int i = 0; i < words.length; i++) {
        isCorrect[i] = false;
        isWrong[i] = false;
      }
      currentIndex = 1;
      _highlightNextWords(
          start: true); // Yeniden başlarken sadece "bitki" seçilebilir
    });
  }

  void _showEndDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('BAŞARDINIZ!'),
          content: const Text('Tebrikler, oyunu başarıyla tamamladınız.'),
          actions: [
            TextButton(
              child: const Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.lightGreen[300], // Arka plan rengini açık yeşil yaptım
      appBar: AppBar(
        backgroundColor: Colors
            .lightGreen[600], // Başlığın arka plan rengini koyu yeşil yaptım
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tavuğu Yeme Götür'),
            SizedBox(height: 1), // Metin ile başlık arasında biraz boşluk bırak
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                '"b" harfiyle başlayan kelimeleri takip ederek tavuğu yeme götürün.',
                style: TextStyle(fontSize: 12), // Yazı boyutunu biraz küçülttüm
                textAlign: TextAlign.center,
                softWrap:
                    true, // Metnin ekranın genişliğine göre sarılmasını sağlar
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.5,
            ),
            itemCount: words.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  color: Colors.grey[300],
                  child: Image.asset(
                      'assets/images/disleksi2_img/tavuk1.jpg'), // Tavuk resmi
                );
              } else if (index == 19) {
                return Container(
                  margin: const EdgeInsets.all(2),
                  color: Colors.grey[300],
                  child: Image.asset(
                      'assets/images/disleksi2_img/yem.jpg'), // Yem resmi
                );
              } else {
                return GestureDetector(
                  onTap: isNext[index]
                      ? () {
                          setState(() {
                            if (words[index].startsWith('b')) {
                              isCorrect[index] = true;
                              isWrong[index] = false;
                              currentIndex = index;
                              _highlightNextWords();
                            } else {
                              isWrong[index] = true;
                              isCorrect[index] = false;
                              _showTryAgainDialog();
                            }

                            if (words[index] == 'balık') {
                              _showEndDialog();
                            }
                          });
                        }
                      : null,
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    color: isCorrect[index]
                        ? Colors.lightGreen
                        : isWrong[index]
                            ? Colors.red
                            : isNext[index]
                                ? Colors.blue
                                : Colors.grey[300],
                    child: Center(
                      child: Text(
                        words[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _showTryAgainDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('YANLIŞ SEÇİM!'),
          content: const Text('Tekrar deneyin.'),
          actions: [
            TextButton(
              child: const Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
            ),
          ],
        );
      },
    );
  }
}
