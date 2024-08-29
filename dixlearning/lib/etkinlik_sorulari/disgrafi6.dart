import 'package:flutter/material.dart';

class EmojiQuiz extends StatefulWidget {
  const EmojiQuiz({super.key});

  @override
  _EmojiQuizState createState() => _EmojiQuizState();
}

class _EmojiQuizState extends State<EmojiQuiz> {
  final List<Map<String, String>> _emojis = [
    {'name': 'Şapka', 'emoji': '🎩'},
    {'name': 'Ampul', 'emoji': '💡'},
    {'name': 'Fırça', 'emoji': '🖌️'},
    {'name': 'Havuç', 'emoji': '🥕'},
    {'name': 'Kahve', 'emoji': '☕'},
    {'name': 'Piyano', 'emoji': '🎹'},
    {'name': 'Kiraz', 'emoji': '🍒'},
    {'name': 'Peynir', 'emoji': '🧀'},
    {'name': 'Makas', 'emoji': '✂️'},
    {'name': 'Mum', 'emoji': '🕯️'},
    {'name': 'Ağaç', 'emoji': '🌳'},
    {'name': 'Anahtar', 'emoji': '🔑'},
    {'name': 'Örümcek', 'emoji': '🕷️'},
  ];

  int _currentIndex = 0;
  String _feedbackMessage = '';
  bool _showNextButton = false;
  bool _showAnswerButton = false;
  bool _isCorrectAnswer = false;
  int _correctCount = 0;
  int _wrongCount = 0;
  bool _quizCompleted = false;
  TextEditingController _controller = TextEditingController();
  late List<Map<String, String>> _shuffledEmojis;

  @override
  void initState() {
    super.initState();
    _shuffledEmojis = List.from(_emojis)..shuffle();
  }

  void _checkAnswer() {
    String userAnswer = _controller.text.trim().toLowerCase();
    String correctAnswer =
        _shuffledEmojis[_currentIndex]['name']!.toLowerCase();

    if (userAnswer == correctAnswer) {
      setState(() {
        _feedbackMessage = 'Doğru!';
        _isCorrectAnswer = true;
        _showNextButton = true;
        _correctCount++;
      });
    } else {
      setState(() {
        _feedbackMessage = 'Tekrar Dene!';
        _showAnswerButton = true;
        _isCorrectAnswer = false;
        _wrongCount++;
      });
    }
  }

  void _showCorrectAnswer() {
    setState(() {
      _feedbackMessage = _shuffledEmojis[_currentIndex]['name']!;
      _showAnswerButton = false;
      _showNextButton = true;
      _isCorrectAnswer = true;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _shuffledEmojis.length - 1) {
      setState(() {
        _currentIndex++;
        _feedbackMessage = '';
        _showNextButton = false;
        _isCorrectAnswer = false;
        _controller.clear();
      });
    } else {
      setState(() {
        _quizCompleted = true;
        _feedbackMessage = 'Tebrikler! Tümünü tamamladın.\n'
            'Doğru: $_correctCount, Yanlış: $_wrongCount';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Görseldeki Ne?',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Görseldeki nesnenin adını verilen kutucuğa yazalım.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.justify,
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _shuffledEmojis[_currentIndex]['emoji']!,
                      style: TextStyle(fontSize: 100),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Buraya yazın...',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (_) => _checkAnswer(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 20),
                    if (!_showAnswerButton && !_showNextButton)
                      ElevatedButton(
                        onPressed: _checkAnswer,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        child: Text('Cevabı Kontrol Et'),
                      ),
                    SizedBox(height: 20),
                    Text(
                      _feedbackMessage,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _isCorrectAnswer ? Colors.green : Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    if (_showAnswerButton)
                      ElevatedButton(
                        onPressed: _showCorrectAnswer,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        child: Text('Cevabı Görüntüle'),
                      ),
                    if (_showNextButton)
                      ElevatedButton(
                        onPressed: _nextQuestion,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        child: Text('Sıradaki Soruya Geç!'),
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
