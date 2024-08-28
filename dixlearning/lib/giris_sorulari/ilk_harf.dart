import 'package:flutter/material.dart';
import 'dart:math';
import 'package:teknofest/giris_sorulari/gorsel_adi.dart';

void main() {
  runApp(MaterialApp(
    home:
        FillMissingLetter(), // Giriş ekranı kaldırıldı, doğrudan oyun açılıyor.
  ));
}

class FillMissingLetter extends StatefulWidget {
  const FillMissingLetter({super.key});

  @override
  _FillMissingLetterState createState() => _FillMissingLetterState();
}

class _FillMissingLetterState extends State<FillMissingLetter> {
  final List<Map<String, String>> wordData = [
    {"word": "pasta", "imageUrl": "assets/images/ilk_harf_img/pasta.jpg"},
    {"word": "örümcek", "imageUrl": "assets/images/ilk_harf_img/orumcek.jpg"},
    {"word": "tabak", "imageUrl": "assets/images/ilk_harf_img/tabak.jpg"},
    {"word": "bebek", "imageUrl": "assets/images/ilk_harf_img/bebek.jpg"},
    {"word": "tavuk", "imageUrl": "assets/images/ilk_harf_img/tavuk.jpg"},
    {"word": "bulut", "imageUrl": "assets/images/ilk_harf_img/bulut.jpg"},
  ];

  List<Map<String, String>> remainingWords =
      []; // Kullanılmamış kelimeler listesi
  late Map<String, String> currentWordData;
  final TextEditingController _controller = TextEditingController();
  bool isCorrect = false;
  bool isAnswered = false;
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    remainingWords = List.from(wordData); // Kopyasını alıyoruz
    getNextWord(); // İlk kelimeyi seçiyoruz
  }

  void getNextWord() {
    setState(() {
      if (remainingWords.isEmpty) {
        _gameOver = true;
        // Oyun bittiğinde görsel adını gösteren sayfaya geçiş yap
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WordFillGame(),
            ));
      } else {
        int randomIndex = Random().nextInt(remainingWords.length);
        currentWordData = remainingWords[randomIndex];
        remainingWords.removeAt(randomIndex); // Seçilen kelimeyi listeden çıkar
        _controller.clear();
        isAnswered = false;
        isCorrect = false;
      }
    });
  }

  void checkAnswer() {
    setState(() {
      isAnswered = true;
      isCorrect = _controller.text.toLowerCase() == currentWordData["word"]![0];
    });

    if (isCorrect) {
      Future.delayed(const Duration(seconds: 1), () {
        getNextWord();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Boşluğa doğru harfi yaz."),
      ),
      body: _gameOver
          ? Center(
              child: const Text(
                "Oyun Bitti!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Boşluğa doğru harfi yaz:",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      currentWordData["imageUrl"]!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "_${currentWordData["word"]!.substring(1)}",
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Eksik harfi yaz",
                      ),
                      maxLength: 1,
                      textCapitalization: TextCapitalization.none,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24),
                      enabled: !isAnswered || isCorrect,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: checkAnswer,
                      child: const Text("Onayla"),
                    ),
                    if (isAnswered && !isCorrect)
                      ElevatedButton(
                        onPressed: getNextWord,
                        child: const Text("Sıradaki Soru"),
                      ),
                    if (isAnswered && !isCorrect)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Yanlış! Doğru harf: '${currentWordData["word"]![0]}'.",
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.red,
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
