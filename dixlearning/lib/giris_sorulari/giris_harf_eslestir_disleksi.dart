import 'dart:math';
import 'package:flutter/material.dart';
import 'package:teknofest/screens/etkinlik_sorulari_screen.dart'; // EtkinlikSorulariScreen import edildi

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.orange
  ];
  final List<String> letters = ['d', 'b', 'm', 'n', 'u', 'ö'];
  final Map<String, Color> letterToColorMap = {};
  final Map<String, bool> correctMatches = {};
  int correctCount = 0;
  int incorrectCount = 0;

  List<String> shuffledLetters = [];

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
          title: const Text('Oyun Bitti!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Doğru: $correctCount'),
              Text('Yanlış: $incorrectCount'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop(); // Dialogu kapat
                // Yeni bir ekran açmak için navigator kullanabiliriz
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EtkinlikSorulariListScreen(),
                  ),
                );
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
        title: const Text('Box Coloring Game'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Harfleri birbiriyle eşleştiriniz.",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: letters.map((letter) {
              return Draggable<String>(
                data: letter,
                feedback: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    width: 40,
                    height: 40,
                    color: colors[letters.indexOf(letter)],
                    child: Center(
                      child: Text(
                        letter,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                childWhenDragging: Container(
                  width: 40,
                  height: 40,
                  color: Colors.grey,
                ),
                child: Container(
                  width: 40,
                  height: 40,
                  color: colors[letters.indexOf(letter)],
                  child: Center(
                    child: Text(
                      letter,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
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
                          : Colors.grey.shade200,
                      radius: 25,
                      child: Center(
                        child: Text(
                          letter,
                          style: const TextStyle(fontSize: 24),
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
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Doğru: $correctCount'),
                  Text('Yanlış: $incorrectCount'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
