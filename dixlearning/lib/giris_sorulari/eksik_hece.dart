import 'package:flutter/material.dart';
import 'package:teknofest/giris_sorulari/renk_sorusu.dart';

class EksikHeceler extends StatefulWidget {
  const EksikHeceler({Key? key}) : super(key: key);

  @override
  _EksikHecelerState createState() => _EksikHecelerState();
}

class _EksikHecelerState extends State<EksikHeceler> {
  final TextEditingController _tavaController = TextEditingController();
  final TextEditingController _cekicController = TextEditingController();
  final TextEditingController _cetvelController = TextEditingController();
  final TextEditingController _armutController = TextEditingController();

  bool _isTavaCompleted = false;
  bool _isCekicCompleted = false;
  bool _isCetvelCompleted = false;
  bool _isArmutCompleted = false;

  bool _isChecked = false;

  Color _tavaColor = Colors.black;
  Color _cekicColor = Colors.black;
  Color _cetvelColor = Colors.black;
  Color _armutColor = Colors.black;

  int _correctAnswers = 0;

  void _checkAllAnswers() {
    _correctAnswers = 0;

    _checkAnswer(_tavaController.text, 'tava', () {
      setState(() {
        _isTavaCompleted = true;
      });
    }, (color) {
      setState(() {
        _tavaColor = color;
      });
    });

    _checkAnswer(_cekicController.text, 'çekiç', () {
      setState(() {
        _isCekicCompleted = true;
      });
    }, (color) {
      setState(() {
        _cekicColor = color;
      });
    });

    _checkAnswer(_cetvelController.text, 'cetvel', () {
      setState(() {
        _isCetvelCompleted = true;
      });
    }, (color) {
      setState(() {
        _cetvelColor = color;
      });
    });

    _checkAnswer(_armutController.text, 'armut', () {
      setState(() {
        _isArmutCompleted = true;
      });
    }, (color) {
      setState(() {
        _armutColor = color;
      });
    });

    setState(() {
      _isChecked = true;
    });

    Future.delayed(const Duration(seconds: 3), _navigateToNextQuestion);
  }

  void _checkAnswer(String input, String correctAnswer, Function onComplete,
      Function updateColor) {
    if (input.toLowerCase() == correctAnswer.toLowerCase()) {
      onComplete();
      updateColor(Colors.green);
      _correctAnswers++;
    } else {
      updateColor(Colors.red);
    }
  }

  void _navigateToNextQuestion() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ColorNamingGame()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoş Geldin Testi!'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Eksik bırakılan heceyi tamamla ve boş bırakılan yere kelimenin tamamını yaz.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
            _buildRow(
              '🍳',
              'ta....',
              _tavaController,
              'tava',
              _isTavaCompleted,
              _tavaColor,
            ),
            _buildRow(
              '🔨',
              '....kiç',
              _cekicController,
              'çekiç',
              _isCekicCompleted,
              _cekicColor,
            ),
            _buildRow(
              '📏',
              '...vel',
              _cetvelController,
              'cetvel',
              _isCetvelCompleted,
              _cetvelColor,
            ),
            _buildRow(
              '🍐',
              'ar....',
              _armutController,
              'armut',
              _isArmutCompleted,
              _armutColor,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _isChecked
                    ? null
                    : () {
                        _checkAllAnswers();
                      },
                child: const Text("Kontrol Et"),
              ),
            ),
            if (_isChecked) _buildResultTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    String emoji,
    String hint,
    TextEditingController controller,
    String correctAnswer,
    bool isCompleted,
    Color textColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 60)),
              const SizedBox(width: 20),
              Text(hint, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: 'Cevap'),
                  style: TextStyle(fontSize: 24, color: textColor),
                  readOnly: isCompleted,
                ),
              ),
            ],
          ),
          if (_isChecked && textColor == Colors.red)
            Text(
              'Doğru cevap: $correctAnswer',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }

  Widget _buildResultTable() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Column(
          children: [
            const Text(
              'Sonuçlar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Doğru sayısı: $_correctAnswers / 4',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
