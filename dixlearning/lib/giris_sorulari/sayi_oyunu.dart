import 'package:flutter/material.dart';

import 'package:teknofest/giris_sorulari/mat_hesaplama.dart'; // Matematik oyunu ekranını import et

class DiskalkuliEgitimPage extends StatefulWidget {
  final VoidCallback? onComplete; // Callback fonksiyonu için gerekli

  const DiskalkuliEgitimPage({super.key, this.onComplete});

  @override
  DiskalkuliEgitimPageState createState() => DiskalkuliEgitimPageState();
}

bool _gameOver = false;

class DiskalkuliEgitimPageState extends State<DiskalkuliEgitimPage> {
  final List<TextEditingController> _controllers =
      List.generate(8, (index) => TextEditingController());

  final List<int> correctCounts = [2, 5, 4, 7, 6, 9, 3, 8];

  void _handleGameEnd() {
    _gameOver = true;
    if (widget.onComplete != null) {
      widget.onComplete!(); // Callback'i çağır
    }

    // Matematik hesaplama sayfasına geçiş
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage2(), // MatHesaplamaPage'e geçiş
      ),
    );
  }

  void verifyCounts() {
    int correctAnswers = 0;
    int incorrectAnswers = 0;

    for (int i = 0; i < _controllers.length; i++) {
      if (int.tryParse(_controllers[i].text) == correctCounts[i]) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
    }

    // Sonuçları göster
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sonuçlar"),
          content: Text(
              "Doğru sayısı: $correctAnswers\nYanlış sayısı: $incorrectAnswers"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleGameEnd();
              },
              child: const Text("Tamam"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aşağıdaki nesnelerin sayısını giriniz.'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              EtkinlikSatiri(
                image1Path: 'assets/images/sayi_oyunu_img/balik1.png',
                controller: _controllers[0],
              ),
              EtkinlikSatiri(
                image1Path: 'assets/images/sayi_oyunu_img/balik2.png',
                controller: _controllers[1],
              ),
              EtkinlikSatiri(
                image1Path: 'assets/images/sayi_oyunu_img/tavsan1.png',
                controller: _controllers[2],
              ),
              EtkinlikSatiri(
                image1Path: 'assets/images/sayi_oyunu_img/tavsan2.png',
                controller: _controllers[3],
              ),
              EtkinlikSatiri(
                image1Path: 'assets/images/sayi_oyunu_img/havuc1.png',
                controller: _controllers[4],
              ),
              EtkinlikSatiri(
                image1Path: 'assets/images/sayi_oyunu_img/havuc2.png',
                controller: _controllers[5],
              ),
              EtkinlikSatiri(
                image1Path: 'assets/images/sayi_oyunu_img/cicek1.png',
                controller: _controllers[6],
              ),
              EtkinlikSatiri(
                image1Path: 'assets/images/sayi_oyunu_img/cicek2.png',
                controller: _controllers[7],
              ),
              ElevatedButton(
                onPressed: verifyCounts,
                child: const Text('Doğrula'),
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

  const EtkinlikSatiri({
    required this.image1Path,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        EtkinlikFotografi(imagePath: image1Path),
        SizedBox(
          width: 100,
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Nesne Sayısı',
            ),
            keyboardType: TextInputType.number,
          ),
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
