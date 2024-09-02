import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> words = [
    '',
    'Bitki',
    'Börek',
    'Değirmen',
    'Peynir',
    'Dünya',
    'Boncuk',
    'Papatya',
    'Bardak',
    'Baston',
    'Balon',
    'Palto',
    'Bilye',
    'Pamuk',
    'Defter',
    'Priz',
    'Başlık',
    'Bütün',
    'Balık',
    ''
  ];

  final List<bool> isCorrect = List<bool>.filled(20, false);
  final List<bool> isWrong = List<bool>.filled(20, false);
  final List<bool> isNext = List<bool>.filled(20, false);
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _highlightNextWords(start: true);
  }

  void _highlightNextWords({bool start = false}) {
    setState(() {
      for (int i = 0; i < words.length; i++) {
        isNext[i] = false;
      }

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
      _highlightNextWords(start: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[300],
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[600],
        title: const Text('Tavuğu Yeme Götürelim!'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.lightGreen[200],
            child: const Text(
              '\n"B" harfiyle başlayan kelimeleri takip edelim ve tavuğu yeme götürelim!\n\n"Bitki" kutucuğuna tıklayarak başlayabilirsin!\n',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.5,
                  ),
                  shrinkWrap: true,
                  itemCount: words.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        margin: const EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: Image.asset(
                            'assets/images/disleksi2_img/tavuk1.jpg'),
                      );
                    } else if (index == 19) {
                      return Container(
                        margin: const EdgeInsets.all(2),
                        color: Colors.grey[300],
                        child:
                            Image.asset('assets/images/disleksi2_img/yem.jpg'),
                      );
                    } else {
                      return GestureDetector(
                        onTap: isNext[index]
                            ? () {
                                setState(() {
                                  if (words[index]
                                      .toLowerCase()
                                      .startsWith('b')) {
                                    isCorrect[index] = true;
                                    isWrong[index] = false;
                                    currentIndex = index;
                                    _highlightNextWords();
                                  } else {
                                    isWrong[index] = true;
                                    isCorrect[index] = false;
                                    _showTryAgainDialog();
                                  }

                                  if (words[index].toLowerCase() == 'balık') {
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
          ),
        ],
      ),
    );
  }

  void _showEndDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('BAŞARDIN!'),
          content: const Text('Tebrikler, oyunu başarıyla tamamladın!'),
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

  void _showTryAgainDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Üzgünüm, yanlış seçim!'),
          content: const Text('Hadi tekrar deneyelim!'),
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
