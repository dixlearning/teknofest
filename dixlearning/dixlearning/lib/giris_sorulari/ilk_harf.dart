import 'package:flutter/material.dart';
import 'dart:math';
import 'package:teknofest/giris_sorulari/gorsel_adi.dart';
import 'package:teknofest/other_functions/game_manager.dart';

class FillMissingLetter extends StatefulWidget {
  FillMissingLetter({super.key, required this.question});
  late Question question;
  @override
  _FillMissingLetterState createState() =>
      _FillMissingLetterState(question: question);
}

class _FillMissingLetterState extends State<FillMissingLetter> {
  _FillMissingLetterState({required this.question});
  late Question question;
  final List<Map<String, String>> wordData = [
    {"word": "pasta", "imageUrl": "assets/images/ilk_harf_img/pasta.jpg"},
    {"word": "örümcek", "imageUrl": "assets/images/ilk_harf_img/orumcek.jpg"},
    {"word": "tabak", "imageUrl": "assets/images/ilk_harf_img/tabak.jpg"},
    {"word": "bebek", "imageUrl": "assets/images/ilk_harf_img/bebek.jpg"},
    {"word": "tavuk", "imageUrl": "assets/images/ilk_harf_img/tavuk.jpg"},
    {"word": "bulut", "imageUrl": "assets/images/ilk_harf_img/bulut.jpg"},
  ];

  List<Map<String, String>> remainingWords = [];
  late Map<String, String> currentWordData;
  final TextEditingController _controller = TextEditingController();
  bool isCorrect = false;
  bool isAnswered = false;
  bool _gameOver = false;
  int correctAnswers = 0;
  int totalQuestions = 0;
  GameManager _gameManager = GameManager();
  @override
  void initState() {
    super.initState();
    remainingWords = List.from(wordData);
    totalQuestions = wordData.length;
    getNextWord();
  }

  void getNextWord() {
    setState(() {
      if (remainingWords.isEmpty) {
        _gameOver = true;
        HandleEndGame();
      } else {
        int randomIndex = Random().nextInt(remainingWords.length);
        currentWordData = remainingWords[randomIndex];
        remainingWords.removeAt(randomIndex);
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
      if (isCorrect) {
        correctAnswers++;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      getNextWord();
    });
  }

  void HandleEndGame() async {
    question.TrueResult = correctAnswers;
    question.FalseResult = totalQuestions - correctAnswers;
    await _gameManager.setGame(context, question);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Hoş Geldin Testi!"),
        backgroundColor: Colors.grey,
      ),
      body: _gameOver
          ? Center(
              child: Text(
                "Oyun Bitti! $correctAnswers / $totalQuestions doğru.",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Eksik harfi bul ve boşluğu doldur.",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Image.asset(
                        currentWordData["imageUrl"]!,
                        width: 200, // Resim boyutu küçültüldü
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "_${currentWordData["word"]!.substring(1)}",
                      style: const TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Buraya yaz.",
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      maxLength: 1,
                      textCapitalization: TextCapitalization.none,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 30),
                      enabled: !isAnswered || isCorrect,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: isAnswered ? null : checkAnswer,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 24),
                      ),
                      child: const Text("Onayla"),
                    ),
                    if (isAnswered)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          isCorrect ? "Doğru!" : "Dikkat et!",
                          style: TextStyle(
                            fontSize: 24,
                            color: isCorrect ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (isAnswered)
                      Text(
                        "Cevap: ${currentWordData["word"]!}.",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
