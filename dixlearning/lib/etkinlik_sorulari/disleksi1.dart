import 'dart:math';
import 'package:flutter/material.dart';

class WordMatchingScreen extends StatefulWidget {
  const WordMatchingScreen({super.key});

  @override
  _WordMatchingScreenState createState() => _WordMatchingScreenState();
}

class _WordMatchingScreenState extends State<WordMatchingScreen>
    with SingleTickerProviderStateMixin {
  final List<String> firstSyllables = [
    'par',
    'ki',
    'dok',
    'gö',
    'men',
    'dü',
    'ör',
    'bon'
  ];
  final List<String> secondSyllables = [
    'mak',
    'tap',
    'tor',
    'bek',
    'dil',
    'dük',
    'dek',
    'cuk'
  ];
  final Map<String, String> correctMatches = {
    'par': 'mak',
    'ki': 'tap',
    'dok': 'tor',
    'gö': 'bek',
    'men': 'dil',
    'dü': 'dük',
    'ör': 'dek',
    'bon': 'cuk',
  };
  late AnimationController _controller;
  late Animation<double> _animation;
  double _rotationAngle = 0.0;
  String? selectedSyllable;
  final Map<String, String> userMatches = {};
  final List<String> usedSyllables = [];
  final List<String> correctSyllables = [];
  int spinCount = 0;
  String? combinedWord;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation =
        Tween<double>(begin: 0, end: 2 * pi * 5).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ))
          ..addListener(() {
            setState(() {
              _rotationAngle = _animation.value;
            });
          });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          int selectedIndex;
          do {
            selectedIndex = Random().nextInt(firstSyllables.length);
          } while (usedSyllables.contains(firstSyllables[selectedIndex]));
          selectedSyllable = firstSyllables[selectedIndex];
          usedSyllables.add(selectedSyllable!);
          combinedWord = null;

          // Eğer seçilen hece doğru değilse çark dönmeye devam eder
          if (correctSyllables.contains(selectedSyllable)) {
            _spinWheel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spinWheel() {
    if (spinCount < 8) {
      setState(() {
        _controller.reset();
        _controller.forward();
        spinCount++;
      });
    }
  }

  void _resetGame() {
    setState(() {
      spinCount = 0;
      usedSyllables.clear();
      userMatches.clear();
      correctSyllables.clear();
      selectedSyllable = null;
      combinedWord = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ÇARKIFELEK'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 5),
            const Text(
              'Doğru heceyi boş kutucuğa sürükleyelim ve anlamlı kelimeler oluşturalım!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _spinWheel,
              child: Transform.rotate(
                angle: _rotationAngle,
                child: CustomPaint(
                  size: const Size(300, 300),
                  painter: WheelPainter(firstSyllables),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'İlk Hece: ${selectedSyllable ?? ''}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            if (selectedSyllable != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedSyllable!,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 10),
                  DragTarget<String>(
                    builder: (
                      BuildContext context,
                      List<String?> incoming,
                      List rejected,
                    ) {
                      return SyllableBox(userMatches[selectedSyllable!] ?? '');
                    },
                    onAccept: (receivedItem) {
                      setState(() {
                        userMatches[selectedSyllable!] = receivedItem;
                        if (correctMatches[selectedSyllable] == receivedItem) {
                          combinedWord = selectedSyllable! + receivedItem;
                          correctSyllables.add(selectedSyllable!);
                        } else {
                          combinedWord = null;
                        }
                      });
                    },
                  ),
                ],
              ),
            if (combinedWord != null)
              Text(
                'Kelime: $combinedWord',
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: secondSyllables.map((syllable) {
                return Draggable<String>(
                  data: syllable,
                  child: SyllableBox(
                    syllable,
                    used: correctSyllables.contains(syllable),
                  ),
                  feedback: SyllableBox(syllable),
                  childWhenDragging: SyllableBox(''),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            if (correctSyllables.length == 8)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: checkAnswers,
                    child: const Text('Kontrol Et'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _resetGame,
                    child: const Text('Yeniden Oyna'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void checkAnswers() {
    int correct = 0;
    int incorrect = 0;
    userMatches.forEach((first, second) {
      if (correctMatches[first] == second) {
        correct++;
      } else {
        incorrect++;
      }
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sonuçlar'),
          content: Text('$correct doğru, $incorrect yanlış cevap'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }
}

class WheelPainter extends CustomPainter {
  final List<String> syllables;

  WheelPainter(this.syllables);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    for (int i = 0; i < syllables.length; i++) {
      double startAngle = (2 * pi / syllables.length) * i;
      double sweepAngle = 2 * pi / syllables.length;
      paint.color = i % 2 == 0
          ? const Color.fromARGB(255, 134, 241, 182)
          : const Color.fromARGB(255, 219, 130, 207);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: syllables[i],
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      final offset = Offset(
        center.dx +
            (radius / 1.5) * cos(startAngle + sweepAngle / 2) -
            textPainter.width / 2,
        center.dy +
            (radius / 1.5) * sin(startAngle + sweepAngle / 2) -
            textPainter.height / 2,
      );
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SyllableBox extends StatelessWidget {
  final String syllable;
  final bool used;

  const SyllableBox(this.syllable, {this.used = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: Text(
        syllable,
        style:
            TextStyle(fontSize: 20, color: used ? Colors.green : Colors.black),
      ),
    );
  }
}
