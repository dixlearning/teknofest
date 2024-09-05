import 'package:flutter/material.dart';
import 'package:teknofest/other_functions/game_manager.dart'; // Matematik oyunu ekranını import et

// ignore: must_be_immutable
class DiskalkuliEgitimPage extends StatefulWidget {
  final VoidCallback? onComplete; // Callback fonksiyonu için gerekli

  DiskalkuliEgitimPage({super.key, this.onComplete, required this.question});
  late Question question;

  @override
  DiskalkuliEgitimPageState createState() =>
      DiskalkuliEgitimPageState(question: question);
}

class DiskalkuliEgitimPageState extends State<DiskalkuliEgitimPage> {
  DiskalkuliEgitimPageState({required this.question});
  late Question question;
  final List<TextEditingController> _controllers =
      List.generate(8, (index) => TextEditingController());

  final List<int> correctCounts = [2, 5, 4, 7, 6, 9, 3, 8];
  final List<Color?> _fieldColors = List.generate(8, (index) => null);
  final List<String> _answers =
      List.generate(8, (index) => ''); // Doğru cevapları saklamak için

// Sıradaki Soru butonunu göstermek için
  GameManager _gameManager = GameManager();
  void _handleGameEnd() async {
    if (widget.onComplete != null) {
      widget.onComplete!(); // Callback'i çağır
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bir sonraki oyuna geçiliyor...')),
    );

    // 3 saniye sonra Matematik hesaplama sayfasına geçiş
    Future.delayed(const Duration(seconds: 3), () {});
  }

  void verifyCounts() async {
    bool allCorrect = false;
    int trueResult = 0;
    int falseResult = 0;
    for (int i = 0; i < _controllers.length; i++) {
      final userAnswer = int.tryParse(_controllers[i].text);
      if (userAnswer == correctCounts[i]) {
        _fieldColors[i] = Colors.green[100];
        _answers[i] = ''; // Cevap doğruysa boş bırak
        trueResult++;
      } else {
        _fieldColors[i] = Colors.red[100];
        _answers[i] =
            'Doğru cevap: ${correctCounts[i]}'; // Cevap yanlışsa doğru cevabı yaz
        falseResult++;
      }
    }
    question.FalseResult = falseResult;
    question.TrueResult = trueResult;
    await _gameManager.setGame(context, question);

    setState(() {
// Sıradaki Soru butonunu göster
    });

    _handleGameEnd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoş Geldin Testi!'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey, // AppBar rengini gri yaptık
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  "Görseldekilerin kaç adet olduklarını bul ve boş bırakılan yerlere sayılarını yaz.",
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 16), // Görseller arasında boşluk bırakıldı
              Column(
                children: [
                  EtkinlikSatiri(
                    image1Path: 'assets/images/sayi_oyunu_img/balik1.png',
                    controller: _controllers[0],
                    fieldColor: _fieldColors[0],
                    answerText: _answers[0],
                  ),
                  const SizedBox(
                      height: 16), // Görseller arasında boşluk bırakıldı
                  EtkinlikSatiri(
                    image1Path: 'assets/images/sayi_oyunu_img/balik2.png',
                    controller: _controllers[1],
                    fieldColor: _fieldColors[1],
                    answerText: _answers[1],
                  ),
                  const SizedBox(
                      height: 16), // Görseller arasında boşluk bırakıldı
                  EtkinlikSatiri(
                    image1Path: 'assets/images/sayi_oyunu_img/tavsan1.png',
                    controller: _controllers[2],
                    fieldColor: _fieldColors[2],
                    answerText: _answers[2],
                  ),
                  const SizedBox(
                      height: 16), // Görseller arasında boşluk bırakıldı
                  EtkinlikSatiri(
                    image1Path: 'assets/images/sayi_oyunu_img/tavsan2.png',
                    controller: _controllers[3],
                    fieldColor: _fieldColors[3],
                    answerText: _answers[3],
                  ),
                  const SizedBox(
                      height: 16), // Görseller arasında boşluk bırakıldı
                  EtkinlikSatiri(
                    image1Path: 'assets/images/sayi_oyunu_img/havuc1.png',
                    controller: _controllers[4],
                    fieldColor: _fieldColors[4],
                    answerText: _answers[4],
                  ),
                  const SizedBox(
                      height: 16), // Görseller arasında boşluk bırakıldı
                  EtkinlikSatiri(
                    image1Path: 'assets/images/sayi_oyunu_img/havuc2.png',
                    controller: _controllers[5],
                    fieldColor: _fieldColors[5],
                    answerText: _answers[5],
                  ),
                  const SizedBox(
                      height: 16), // Görseller arasında boşluk bırakıldı
                  EtkinlikSatiri(
                    image1Path: 'assets/images/sayi_oyunu_img/cicek1.png',
                    controller: _controllers[6],
                    fieldColor: _fieldColors[6],
                    answerText: _answers[6],
                  ),
                  const SizedBox(
                      height: 16), // Görseller arasında boşluk bırakıldı
                  EtkinlikSatiri(
                    image1Path: 'assets/images/sayi_oyunu_img/cicek2.png',
                    controller: _controllers[7],
                    fieldColor: _fieldColors[7],
                    answerText: _answers[7],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: verifyCounts,
                  child: const Text('Doğrula'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EtkinlikSatiri extends StatelessWidget {
  final String image1Path;
  final TextEditingController controller;
  final Color? fieldColor;
  final String answerText;

  const EtkinlikSatiri({
    required this.image1Path,
    required this.controller,
    this.fieldColor,
    required this.answerText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EtkinlikFotografi(imagePath: image1Path),
            const SizedBox(width: 16), // Biraz boşluk ekledik
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 16.0), // Sağdan bir tık boşluk
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: 'Nesne Sayısı:',
                    filled: true,
                    fillColor: fieldColor,
                    suffixText: answerText.isNotEmpty
                        ? answerText
                        : null, // Yanlış cevapların altına doğru cevabı yaz
                    suffixStyle: TextStyle(
                        color: Colors
                            .red), // Yanlış cevapların altındaki doğru cevabı kırmızı renkte göster
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (int.tryParse(value) == null || value.isEmpty) {
                      controller.text = '';
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class EtkinlikFotografi extends StatelessWidget {
  final String imagePath;

  const EtkinlikFotografi({
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: 100,
      height: 100,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.broken_image, size: 100);
      },
    );
  }
}
