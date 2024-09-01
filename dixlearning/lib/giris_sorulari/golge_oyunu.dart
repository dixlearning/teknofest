import 'package:flutter/material.dart';
import 'package:teknofest/giris_sorulari/giris_harf_eslestir_disleksi.dart';
import 'package:teknofest/other_functions/game_manager.dart'; // Import ediliyor

class WordShadowMatchGame extends StatefulWidget {
  WordShadowMatchGame({super.key, required this.question});
  late Question question;
  @override
  _WordShadowMatchGameState createState() =>
      _WordShadowMatchGameState(question: question);
}

class _WordShadowMatchGameState extends State<WordShadowMatchGame> {
  _WordShadowMatchGameState({required this.question});
  late Question question;
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
  int correctAnswer = 0;
  int incorrectAnswer = 0;
  GameManager _gameManager = GameManager();

  final Map<String, String> matches = {};
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

  void _handleGameEnd() async {
    question.TrueResult = correctAnswer;
    question.FalseResult = incorrectAnswer;
    await _gameManager.setGame(context, question);
  }

  void checkMatch() {
    if (shadowImages[words.indexOf(selectedWord!)] == selectedShadow) {
      setState(() {
        matches[selectedWord!] = selectedShadow!;
        selectedWord = null;
        selectedShadow = null;
        correctAnswer++;
        if (matches.length == words.length) {
          _handleGameEnd();
        }
      });
    } else {
      incorrectAnswer++;
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
        automaticallyImplyLeading: false,
        title: const Text('Hoş Geldin Testi!'),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Başlık Metni
            Text(
              'Kelimeleri gölgeleriyle eşleştir.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            // Kelimeler ve Gölge Resimleri
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(words.length, (index) {
                  String word = words[index];
                  String shadow = shuffledShadowImages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Kelime Butonu
                        Container(
                          width: 150,
                          height: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            onPressed: () => selectWord(word),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: matches[word] == 'wrong'
                                  ? Colors.red
                                  : (matches[word] != null
                                      ? Colors.green
                                      : (selectedWord == word
                                          ? Colors.blue
                                          : Colors.grey[300])),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              word,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 50),
                        // Gölge Resmi Butonu
                        GestureDetector(
                          onTap: () => selectShadow(shadow),
                          child: Container(
                            width: 150,
                            height: 60,
                            decoration: BoxDecoration(
                              color: matches.containsValue(shadow)
                                  ? Colors.green
                                  : (selectedShadow == shadow
                                      ? Colors.blue
                                      : Colors.grey[300]),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Image.asset(
                              shadow,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
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
