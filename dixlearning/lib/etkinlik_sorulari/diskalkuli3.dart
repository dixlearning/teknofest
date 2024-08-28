import 'package:flutter/material.dart';

class MathQuiz extends StatefulWidget {
  const MathQuiz({super.key});

  @override
  _MathQuizState createState() => _MathQuizState();
}

class _MathQuizState extends State<MathQuiz> {
  final _leftController = TextEditingController();
  final _rightController = TextEditingController();
  String _question = '';
  String _answerPosition = '';
  String _positionMessage = '';
  String _message = '';
  int _currentQuestionIndex = 0;
  bool _isAnswerCorrect = false;

  final List<Map<String, dynamic>> _questions = [
    {'left': 3, 'right': 4, 'operation': 'x', 'answerPosition': 'left'},
    {'left': 6, 'right': 2, 'operation': '/', 'answerPosition': 'right'},
    {'left': 8, 'right': 5, 'operation': 'x', 'answerPosition': 'right'},
    {'left': 9, 'right': 3, 'operation': '/', 'answerPosition': 'left'},
    {'left': 7, 'right': 5, 'operation': 'x', 'answerPosition': 'left'},
    // Daha fazla soru ekleyin
  ];

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    if (_currentQuestionIndex < _questions.length) {
      final question = _questions[_currentQuestionIndex];
      final leftNumber = question['left'];
      final rightNumber = question['right'];
      final operation = question['operation'];
      final answerPosition = question['answerPosition'];

      _question = '$leftNumber $operation $rightNumber = ?';
      _answerPosition = answerPosition;
      _positionMessage = _answerPosition == 'left'
          ? 'Cevabı SOLda bulunan daireye yazalım!.'
          : 'Cevabı SAĞda bulunan daireye yazalım!';

      setState(() {
        _isAnswerCorrect = false;
      });
    } else {
      setState(() {
        _message = 'Harika! Tüm soruları tamamladın.';
      });
    }
  }

  void _checkAnswer() {
    final question = _questions[_currentQuestionIndex];
    final leftNumber = question['left'];
    final rightNumber = question['right'];
    final operation = question['operation'];
    final correctAnswer =
        operation == 'x' ? leftNumber * rightNumber : leftNumber ~/ rightNumber;

    final leftAnswer = _leftController.text.trim();
    final rightAnswer = _rightController.text.trim();

    final isLeftCorrect = leftAnswer.isNotEmpty &&
        _answerPosition == 'left' &&
        int.tryParse(leftAnswer) == correctAnswer;
    final isRightCorrect = rightAnswer.isNotEmpty &&
        _answerPosition == 'right' &&
        int.tryParse(rightAnswer) == correctAnswer;

    // Sadece bir alanın dolu olduğundan emin olun
    final isSingleFieldFilled =
        (leftAnswer.isNotEmpty && rightAnswer.isEmpty) ||
            (leftAnswer.isEmpty && rightAnswer.isNotEmpty);

    if ((isLeftCorrect || isRightCorrect) && isSingleFieldFilled) {
      setState(() {
        _message = 'Tebrikler! Doğru cevap.';
        _isAnswerCorrect = true;
      });
    } else {
      setState(() {
        _message =
            'Üzgünüm, Yanlış cevap. Cevabı doğru yere yazdığından emin ol!\n\nDoğru cevabı sadece 1 daireye yazmayı unutma!';
        _isAnswerCorrect = false;
      });
    }
  }

  void _nextQuestion() {
    _currentQuestionIndex++;
    _generateQuestion();
    _leftController.clear();
    _rightController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Birlikte Hesaplayalım!'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _question,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                _positionMessage,
                style: const TextStyle(fontSize: 18, color: Colors.blue),
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 180, // Boyutu artırdık
                          decoration: BoxDecoration(
                            color: Colors.pink[200],
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Pembe Daire',
                                  style: TextStyle(
                                    fontSize: 22, // Yazı boyutunu artırdık
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: _leftController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Colors.transparent,
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20, // Yazı boyutunu artırdık
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 180, // Boyutu artırdık
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[200],
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Mavi Daire',
                                  style: TextStyle(
                                    fontSize: 22, // Yazı boyutunu artırdık
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: _rightController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Colors.transparent,
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20, // Yazı boyutunu artırdık
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellowAccent,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: const Text(
                  'Cevabı Kontrol Et',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              if (_isAnswerCorrect)
                ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                  ),
                  child: const Text(
                    'Sonraki Soru',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                _message,
                style: TextStyle(
                  fontSize: 18,
                  color: _message.contains('Tebrikler')
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
