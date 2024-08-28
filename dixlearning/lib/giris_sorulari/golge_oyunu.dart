import 'package:flutter/material.dart';
import 'package:teknofest/giris_sorulari/giris_harf_eslestir_disleksi.dart'; // Import ediliyor

class WordShadowMatchGame extends StatefulWidget {
  const WordShadowMatchGame({super.key});

  @override
  _WordShadowMatchGameState createState() => _WordShadowMatchGameState();
}

class _WordShadowMatchGameState extends State<WordShadowMatchGame> {
  final List<String> words = [
    'Ördek',
    'Şemsiye',
    'Şapka',
    'Davul',
    'Mantar',
    'Araba'
  ];
  final List<String> shadowImages = [
    'assets/images/golge_oyunu_img/duck.png',
    'assets/images/golge_oyunu_img/umbrella.png',
    'assets/images/golge_oyunu_img/hat.png',
    'assets/images/golge_oyunu_img/drum.png',
    'assets/images/golge_oyunu_img/mushroom.png',
    'assets/images/golge_oyunu_img/car.png',
  ];
  List<String> shuffledShadowImages = [];
  String? selectedWord;
  String? selectedShadow;
  final Map<String, String> matches = {};
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    shuffledShadowImages = List.from(shadowImages)..shuffle();
  }

  void selectWord(String word) {
    setState(() {
      selectedWord = word;
      if (selectedShadow != null) {
        checkMatch();
      }
    });
  }

  void selectShadow(String shadow) {
    setState(() {
      selectedShadow = shadow;
      if (selectedWord != null) {
        checkMatch();
      }
    });
  }

  void _handleGameEnd() {
    _gameOver = true;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(), // Yönlendirme yapılacak sayfa
      ),
    );
  }

  void checkMatch() {
    if (shadowImages[words.indexOf(selectedWord!)] == selectedShadow) {
      setState(() {
        matches[selectedWord!] = selectedShadow!;
        selectedWord = null;
        selectedShadow = null;
        if (matches.length == words.length) {
          _handleGameEnd();
        }
      });
    } else {
      setState(() {
        matches[selectedWord!] = 'wrong';
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            matches.remove(selectedWord!);
          });
        });
        selectedWord = null;
        selectedShadow = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelimeleri Gölgeleriyle Eşleştirme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(words.length, (index) {
                  String word = words[index];
                  String shadow = shuffledShadowImages[index];
                  return Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => selectWord(word),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            color: matches[word] == 'wrong'
                                ? Colors.red
                                : (matches[word] != null
                                    ? Colors.green
                                    : (selectedWord == word
                                        ? Colors.blue
                                        : Colors.grey[300])),
                            child: Text(
                              word,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => selectShadow(shadow),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            color: matches.containsValue(shadow)
                                ? Colors.green
                                : (selectedShadow == shadow
                                    ? Colors.blue
                                    : Colors.grey[300]),
                            child: Image.asset(
                              shadow,
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
