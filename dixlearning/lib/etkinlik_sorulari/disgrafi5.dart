import 'package:flutter/material.dart';
import 'dart:async';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Baş Harfini Söyle!')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ActivityScreen()),
            );
          },
          child: Text('Başla', style: TextStyle(fontSize: 24)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink, // Düzeltilmiş
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final _controller = TextEditingController();
  String _feedbackMessage = '';
  Color _feedbackColor = Colors.transparent;
  Color _containerColor = Colors.pinkAccent;
  Color _buttonColor = Colors.pink;

  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  Stopwatch _stopwatch = Stopwatch();

  final List<Map<String, dynamic>> _questions = [
    {
      'items': [
        {'emoji': '🎈', 'name': 'Balon', 'letter': 'b'},
        {'emoji': '🥤', 'name': 'Bardak', 'letter': 'b'},
        {'emoji': '💠', 'name': 'Boncuk', 'letter': 'b'},
        {'emoji': '🎨', 'name': 'Boya', 'letter': 'b'},
      ],
      'question': 'Bu nesnelerin hangi harfle başladığını yazın',
      'colors': {
        'container': Colors.pinkAccent,
        'button': Colors.pink,
      },
    },
    {
      'items': [
        {'emoji': '🗄️', 'name': 'Dolap', 'letter': 'd'},
        {'emoji': '🌊', 'name': 'Deniz', 'letter': 'd'},
        {'emoji': '🌍', 'name': 'Dünya', 'letter': 'd'},
        {'emoji': '📒', 'name': 'Defter', 'letter': 'd'},
      ],
      'question': 'Bu nesnelerin hangi harfle başladığını yazın',
      'colors': {
        'container': Colors.lightBlueAccent,
        'button': Colors.blue,
      },
    },
    {
      'items': [
        {'emoji': '🖐️', 'name': 'Parmak', 'letter': 'p'},
        {'emoji': '👖', 'name': 'Pantolon', 'letter': 'p'},
        {'emoji': '🛍️', 'name': 'Poşet', 'letter': 'p'},
        {'emoji': '🪟', 'name': 'Perde', 'letter': 'p'},
      ],
      'question': 'Bu nesnelerin hangi harfle başladığını yazın',
      'colors': {
        'container': Colors.lightGreenAccent,
        'button': Colors.green,
      },
    },
    {
      'items': [
        {'emoji': '📦', 'name': 'Kutu', 'letter': 'k'},
        {'emoji': '🛋️', 'name': 'Kanepe', 'letter': 'k'},
        {'emoji': '🐱', 'name': 'Kedi', 'letter': 'k'},
        {'emoji': '🐶', 'name': 'Köpek', 'letter': 'k'},
      ],
      'question': 'Bu nesnelerin hangi harfle başladığını yazın',
      'colors': {
        'container': Colors.orangeAccent,
        'button': Colors.orange,
      },
    },
    {
      'items': [
        {'emoji': '👡', 'name': 'Terlik', 'letter': 't'},
        {'emoji': '🪨', 'name': 'Taş', 'letter': 't'},
        {'emoji': '🥫', 'name': 'Teneke', 'letter': 't'},
        {'emoji': '🧈', 'name': 'Tereyağ', 'letter': 't'},
      ],
      'question': 'Bu nesnelerin hangi harfle başladığını yazın',
      'colors': {
        'container': Colors.purpleAccent,
        'button': Colors.purple,
      },
    },
  ];

  void _checkAnswer() {
    setState(() {
      final userAnswer = _controller.text.toLowerCase();
      bool isCorrect = _questions[_currentQuestionIndex]['items']
          .any((item) => item['letter'] == userAnswer);
      if (isCorrect) {
        _feedbackMessage = 'Doğru!';
        _feedbackColor = Colors.greenAccent;
        _correctAnswers++;
      } else {
        _feedbackMessage = 'Yanlış!';
        _feedbackColor = Colors.redAccent;
        _wrongAnswers++;
      }

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          if (_currentQuestionIndex < _questions.length - 1) {
            _currentQuestionIndex++;
            _controller.clear();
            _feedbackMessage = '';
            _feedbackColor = Colors.transparent;

            final colors = _questions[_currentQuestionIndex]['colors'];
            _containerColor = colors['container']!;
            _buttonColor = colors['button']!;
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EndScreen(
                  duration: _stopwatch.elapsed,
                  correctAnswers: _correctAnswers,
                  wrongAnswers: _wrongAnswers,
                ),
              ),
            );
          }
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final items = currentQuestion['items'] as List<Map<String, String>>;

    return Scaffold(
      appBar: AppBar(title: Text('Oyun')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  for (var item in items)
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color: _containerColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: _containerColor.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item['emoji']!,
                            style: TextStyle(fontSize: 40),
                          ),
                          SizedBox(height: 5),
                          Text(
                            item['name']!,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: currentQuestion['question'],
                        labelStyle: TextStyle(color: _buttonColor),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _buttonColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _checkAnswer,
                      child: Text('Kontrol Et'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _buttonColor, // Düzeltilmiş
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      color: _feedbackColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        _feedbackMessage,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EndScreen extends StatelessWidget {
  final Duration duration;
  final int correctAnswers;
  final int wrongAnswers;

  EndScreen({
    required this.duration,
    required this.correctAnswers,
    required this.wrongAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Oyun Bitti')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Süre: ${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Text(
                'Doğru Sayısı: $correctAnswers',
                style: TextStyle(fontSize: 24, color: Colors.green),
              ),
              SizedBox(height: 20),
              Text(
                'Yanlış Sayısı: $wrongAnswers',
                style: TextStyle(fontSize: 24, color: Colors.red),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => StartScreen()),
                  );
                },
                child: Text('Tekrar Oyna'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // Düzeltilmiş
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textStyle:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
