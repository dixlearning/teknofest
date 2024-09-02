import 'package:flutter/material.dart';
import 'package:teknofest/giris_sorulari/golge_oyunu.dart';
import 'package:teknofest/other_functions/game_manager.dart';

class WordFillGame extends StatefulWidget {
  WordFillGame({super.key, required this.question});
  late Question question;
  @override
  _WordFillGameState createState() => _WordFillGameState(question: question);
}

class _WordFillGameState extends State<WordFillGame> {
  _WordFillGameState({required this.question});
  late Question question;
  final List<Map<String, String>> items = [
    {'emoji': '🪟', 'word': ' ', 'answer': 'pencere'},
    {'emoji': '👓', 'word': ' ', 'answer': 'gözlük'},
    {'emoji': '🐕', 'word': ' ', 'answer': 'köpek'},
    {'emoji': '🍦', 'word': ' ', 'answer': 'dondurma'},
    {'emoji': '🍉', 'word': ' ', 'answer': 'karpuz'},
  ];

  final List<List<String>> correctLetters = [];
  final List<List<String>> userLetters = [];
  final List<Color> colors = [];
  late List<String> alphabet;
  int correctUserAnswer = 0;
  int incorrectUserAnswer = 0;
  GameManager _gameManager = GameManager();
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < items.length; i++) {
      colors.add(Colors.transparent);

      correctLetters.add(items[i]['answer']!.split(''));
      userLetters.add(List.filled(items[i]['answer']!.length, ''));
    }
    alphabet = 'abcçdefgğhıijklmnoöprsştuüvyz'.split('');
    alphabet.shuffle(); // Harfleri karıştır
  }

  void _handleGameEnd() async {
    question.TrueResult = correctUserAnswer;
    question.FalseResult = incorrectUserAnswer;
    await _gameManager.setGame(context, question);
  }

  void _checkAnswers(int index) {
    String userAnswer =
        userLetters[index].join('').toLowerCase().replaceAll(' ', '');
    String correctAnswer = items[index]['answer']!.toLowerCase();

    setState(() {
      if (userAnswer == correctAnswer) {
        colors[index] = Colors.green.withOpacity(0.3);
        correctUserAnswer++;
      } else {
        colors[index] = Colors.red.withOpacity(0.3);
        incorrectUserAnswer++;
      }

      bool allChecked = true;
      for (var color in colors) {
        if (color == Colors.transparent) {
          allChecked = false;
          break;
        }
      }
      if (allChecked) {
        _gameOver = true;
        Future.delayed(const Duration(seconds: 2), () {
          if (_gameOver) {
            _handleGameEnd();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
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
            const Text(
              'Aşağıda bulunan görsellerin adını yazmama yardım et!\n\nHarf havuzundan harfleri yakala ve doğru kutucuğa sürüklemeyi unutma!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              items[index]['emoji']!,
                              style: const TextStyle(fontSize: 40),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: List.generate(
                                  correctLetters[index].length,
                                  (letterIndex) {
                                    return DragTarget<String>(
                                      builder: (BuildContext context,
                                          List<String?> incoming,
                                          List<dynamic> rejected) {
                                        return Container(
                                          height: 50,
                                          width: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: colors[index] !=
                                                    Colors.transparent
                                                ? colors[index]
                                                : (incoming.isEmpty
                                                    ? Colors.blue
                                                    : Colors.blue[200]),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Text(
                                            userLetters[index][letterIndex],
                                            style: const TextStyle(
                                                fontSize: 24,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 253)),
                                          ),
                                        );
                                      },
                                      onWillAcceptWithDetails: (details) =>
                                          true,
                                      onAcceptWithDetails: (details) {
                                        setState(() {
                                          userLetters[index][letterIndex] =
                                              details.data as String;
                                        });
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _checkAnswers(index);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 170, 201, 255),
                              ),
                              child: const Text('Onayla'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Divider(),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Text(
              'Harf Havuzu (Tut-Sürükle-Bırak)',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                alphabet.length,
                (index) => Draggable<String>(
                  data: alphabet[index],
                  feedback: Material(
                    color: Colors.blue.withOpacity(0.7),
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        alphabet[index],
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                  child: Material(
                    color: Colors.blue.withOpacity(0.2),
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        alphabet[index],
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
