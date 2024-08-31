import 'dart:math';
import 'package:flutter/material.dart';
import 'package:teknofest/other_functions/game_manager.dart';
import 'package:teknofest/screens/etkinlik_sorulari_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.question});
  late Question question;
  @override
  State<HomePage> createState() => _HomePageState(question: question);
}

class _HomePageState extends State<HomePage> {
  _HomePageState({required this.question});
  final List<Color> colors = [
    Colors.redAccent,
    Colors.amber,
    Colors.lightBlueAccent,
    Colors.deepPurpleAccent,
    Colors.lightGreen,
    Colors.orangeAccent
  ];
  final List<String> letters = ['d', 'b', 'm', 'n', 'u', 'ö'];
  final Map<String, Color> letterToColorMap = {};
  final Map<String, bool> correctMatches = {};
  int correctCount = 0;
  int incorrectCount = 0;
  late Question question;
  List<String> shuffledLetters = [];
  GameManager _gameManager = GameManager();
  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _checkGameCompletion() {
    if (correctCount == letters.length) {
      _showScoreDialog();
    }
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Oyun Bitti!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Doğru: $correctCount',
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
              Text(
                'Yanlış: $incorrectCount',
                style: const TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Tamam',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                question.TrueResult = correctCount;
                question.FalseResult = incorrectCount;
                await _gameManager.setGame(context, question);
              },
            ),
          ],
        );
      },
    );
  }

  void _startNewGame() {
    setState(() {
      correctCount = 0;
      incorrectCount = 0;
      shuffledLetters = List.from(letters)..shuffle(Random());
      for (var letter in letters) {
        letterToColorMap[letter] = Colors.transparent;
        correctMatches[letter] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Hoş Geldin Testi!'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Daireleri boyamama yardım et!\n\nKutucuklarda bulunan renkleri doğru harflerle eşleştir.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: letters.map((letter) {
                return Draggable<String>(
                  data: letter,
                  feedback: Material(
                    type: MaterialType.transparency,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: colors[letters.indexOf(letter)],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          letter,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  childWhenDragging: Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey,
                  ),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: colors[letters.indexOf(letter)],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        letter,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                padding: const EdgeInsets.all(20),
                children: shuffledLetters.map((letter) {
                  return DragTarget<String>(
                    onWillAccept: (receivedLetter) => !correctMatches[letter]!,
                    onAccept: (receivedLetter) {
                      setState(() {
                        if (letter == receivedLetter) {
                          correctMatches[letter] = true;
                          letterToColorMap[letter] =
                              colors[letters.indexOf(letter)];
                          correctCount++;
                        } else {
                          incorrectCount++;
                        }
                        _checkGameCompletion();
                      });
                    },
                    builder: (context, acceptedItems, rejectedItems) {
                      return CircleAvatar(
                        backgroundColor: correctMatches[letter]!
                            ? colors[letters.indexOf(letter)]
                            : Colors.grey.shade300,
                        radius: 30,
                        child: Center(
                          child: Text(
                            letter,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Doğru: $correctCount',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'Yanlış: $incorrectCount',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
