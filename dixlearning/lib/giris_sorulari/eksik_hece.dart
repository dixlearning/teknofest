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

  bool _isTavaChecked = false;
  bool _isCekicChecked = false;
  bool _isCetvelChecked = false;
  bool _isArmutChecked = false;

  Color _tavaColor = Colors.black;
  Color _cekicColor = Colors.black;
  Color _cetvelColor = Colors.black;
  Color _armutColor = Colors.black;

  void _checkAnswer(String input, String correctAnswer, Function onComplete,
      Function updateColor) {
    setState(() {
      if (input.toLowerCase() == correctAnswer.toLowerCase()) {
        onComplete();
        updateColor(Colors.green); // Doğru cevap için yeşil renk
      } else {
        updateColor(Colors.red); // Yanlış cevap için kırmızı renk
      }
    });
  }

  void _checkIfAllQuestionsCompleted() {
    if (_isTavaChecked &&
        _isCekicChecked &&
        _isCetvelChecked &&
        _isArmutChecked) {
      _navigateToNextQuestion();
    }
  }

  void _navigateToNextQuestion() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ColorNamingGame()),
    );
  }

  Widget _buildRow(
    String emoji,
    String hint,
    TextEditingController controller,
    String correctAnswer,
    bool isCompleted,
    Function onComplete,
    bool isChecked,
    Function onCheck,
    Color textColor,
    Function updateColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(emoji,
                  style:
                      const TextStyle(fontSize: 60)), // Emoji boyutu artırıldı
              const SizedBox(width: 20),
              Text(hint,
                  style:
                      const TextStyle(fontSize: 28)), // Yazı boyutu artırıldı
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: 'Cevap'),
                  style: TextStyle(
                      fontSize: 24,
                      color: textColor), // Metin rengi güncellendi
                  readOnly:
                      isCompleted, // Eğer soru tamamlandıysa kutu salt okunur olacak
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: isChecked
                ? null
                : () {
                    _checkAnswer(controller.text, correctAnswer, onComplete,
                        updateColor);
                    onCheck(); // Soru kontrol edildi
                    _checkIfAllQuestionsCompleted(); // Tüm sorular kontrol edildiyse yönlendir
                  },
            child: const Text("Kontrol Et"),
          ),
          if (isChecked && textColor == Colors.red)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eksik Heceler')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Görsellerin isminde eksik bırakılan heceyi tamamlayarak yazınız.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            _buildRow(
              '🍳',
              'ta....',
              _tavaController,
              'tava',
              _isTavaCompleted,
              () {
                setState(() {
                  _isTavaCompleted = true;
                });
              },
              _isTavaChecked,
              () {
                setState(() {
                  _isTavaChecked = true;
                });
              },
              _tavaColor,
              (Color color) {
                setState(() {
                  _tavaColor = color;
                });
              },
            ),
            _buildRow(
              '🔨',
              '....kiç',
              _cekicController,
              'çekiç',
              _isCekicCompleted,
              () {
                setState(() {
                  _isCekicCompleted = true;
                });
              },
              _isCekicChecked,
              () {
                setState(() {
                  _isCekicChecked = true;
                });
              },
              _cekicColor,
              (Color color) {
                setState(() {
                  _cekicColor = color;
                });
              },
            ),
            _buildRow(
              '📏',
              '...vel',
              _cetvelController,
              'cetvel',
              _isCetvelCompleted,
              () {
                setState(() {
                  _isCetvelCompleted = true;
                });
              },
              _isCetvelChecked,
              () {
                setState(() {
                  _isCetvelChecked = true;
                });
              },
              _cetvelColor,
              (Color color) {
                setState(() {
                  _cetvelColor = color;
                });
              },
            ),
            _buildRow(
              '🍐',
              'ar....',
              _armutController,
              'armut',
              _isArmutCompleted,
              () {
                setState(() {
                  _isArmutCompleted = true;
                });
              },
              _isArmutChecked,
              () {
                setState(() {
                  _isArmutChecked = true;
                });
              },
              _armutColor,
              (Color color) {
                setState(() {
                  _armutColor = color;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
