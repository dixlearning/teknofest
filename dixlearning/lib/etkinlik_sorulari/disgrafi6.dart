import 'package:flutter/material.dart';

class EmojiQuiz extends StatefulWidget {
  const EmojiQuiz({super.key});

  @override
  _EmojiQuizState createState() => _EmojiQuizState();
}

class _EmojiQuizState extends State<EmojiQuiz> {
  final List<Map<String, String>> _emojis = [
    {'name': 'şapka', 'emoji': '🎩'},
    {'name': 'ampul', 'emoji': '💡'},
    {'name': 'fırça', 'emoji': '🖌️'},
    {'name': 'havuç', 'emoji': '🥕'},
    {'name': 'kahve', 'emoji': '☕'},
    {'name': 'piyano', 'emoji': '🎹'},
    {'name': 'kiraz', 'emoji': '🍒'},
    {'name': 'peynir', 'emoji': '🧀'},
    {'name': 'makas', 'emoji': '✂️'},
    {'name': 'mum', 'emoji': '🕯️'},
    {'name': 'ağaç', 'emoji': '🌳'},
    {'name': 'anahtar', 'emoji': '🔑'},
    {'name': 'örümcek', 'emoji': '🕷️'},
  ];

  int _currentIndex = 0;
  String _feedbackMessage = '';
  bool _showNextButton = false;
  bool _isCorrectAnswer = false;
  String _correctAnswer = '';
  TextEditingController _controller = TextEditingController();

  void _checkAnswer() {
    String userAnswer = _controller.text.trim().toLowerCase();
    String correctAnswer = _emojis[_currentIndex]['name']!;

    if (userAnswer == correctAnswer) {
      setState(() {
        _feedbackMessage = 'Doğru!';
        _isCorrectAnswer = true;
        _correctAnswer = userAnswer;
        _showNextButton = true;
      });
    } else {
      setState(() {
        _feedbackMessage = 'Yanlış! Doğru cevap: $correctAnswer';
        _showNextButton = true;
        _isCorrectAnswer = false;
      });
    }
  }

  void _nextQuestion() {
    setState(() {
      _currentIndex++;
      _feedbackMessage = '';
      _showNextButton = false;
      _isCorrectAnswer = false;
      _controller.clear();

      if (_currentIndex >= _emojis.length) {
        _currentIndex = 0;
        _feedbackMessage = 'Tebrikler! Tüm emojileri tamamladınız.';
        _showNextButton = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emoji Tanıma Etkinliği'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _emojis[_currentIndex]['emoji']!,
                style: TextStyle(fontSize: 100),
              ),
              if (_isCorrectAnswer)
                TextField(
                  controller: TextEditingController(text: _correctAnswer),
                  decoration: InputDecoration(
                    labelText: 'Görseldeki nedir?',
                    labelStyle: TextStyle(color: Colors.green),
                    enabled: false,
                  ),
                  style: TextStyle(color: Colors.green),
                )
              else
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Görseldeki nedir?',
                  ),
                  onSubmitted: (_) => _checkAnswer(),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkAnswer,
                child: Text('Cevabı Kontrol Et'),
              ),
              SizedBox(height: 20),
              Text(
                _feedbackMessage,
                style: TextStyle(fontSize: 24, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              if (_showNextButton)
                ElevatedButton(
                  onPressed: _nextQuestion,
                  child: Text('Sıradaki Soruya Geç'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
