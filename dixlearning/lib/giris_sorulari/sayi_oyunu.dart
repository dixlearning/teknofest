import 'package:flutter/material.dart';
import 'package:teknofest/giris_sorulari/mat_hesaplama.dart'; // Matematik oyunu ekranını import et

class DiskalkuliEgitimPage extends StatefulWidget {
  final VoidCallback? onComplete; // Callback fonksiyonu için gerekli

  const DiskalkuliEgitimPage({super.key, this.onComplete});

  @override
  DiskalkuliEgitimPageState createState() => DiskalkuliEgitimPageState();
}

class DiskalkuliEgitimPageState extends State<DiskalkuliEgitimPage> {
  final List<TextEditingController> _controllers =
      List.generate(8, (index) => TextEditingController());

  final List<int> correctCounts = [2, 5, 4, 7, 6, 9, 3, 8];
  final List<Color?> _fieldColors = List.generate(8, (index) => null);

  void _handleGameEnd() {
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
    for (int i = 0; i < _controllers.length; i++) {
      if (int.tryParse(_controllers[i].text) == correctCounts[i]) {
        _fieldColors[i] = Colors.green[100];
      } else {
        _fieldColors[i] = Colors.red[100];
      }
    }

    setState(() {}); // Renklerin güncellenmesi için
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoş Geldin Testi!'),
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
                  ),
                  const SizedBox(
                      height: 16), // Görseller arasında boşluk bırakıldı
                  EtkinlikSatiri(
                    image1Path: 'assets/images/sayi_oyunu_img/balik2.png',
                    controller: _controllers[1],
                    fieldColor: _fieldColors[1],
                  ),
                  const SizedBox(
                      height: 16), // Görseller arasında boşluk bırakıldı
                  EtkinlikSatiri(
                    image1Path: 'assets/images/sayi_oyunu_img/tavsan1.png',
                    controller: _controllers[2],
                    fieldColor: _fieldColors[2],
                  ),
                  const SizedBox(
                      height: 16), // Görseller arasında boşluk bırakıldı
                  EtkinlikSatiri(
                    image1Path: 'assets/images/sayi_oyunu_img/tavsan2.png',
                    controller: _controllers[3],
                    fieldColor: _fieldColors[3],
                  ),
                  const SizedBox(
                      height: 16), // Görseller arasında boşluk bırakıldı
                  EtkinlikSatiri(
                    image1Path: 'assets/images/sayi_oyunu_img/havuc1.png',
                    controller: _controllers[4],
                    fieldColor: _fieldColors[4],
                  ),
                  const SizedBox(
                      height: 16), // Görseller arasında boşluk bırakıldı
                  EtkinlikSatiri(
                    image1Path: 'assets/images/sayi_oyunu_img/havuc2.png',
                    controller: _controllers[5],
                    fieldColor: _fieldColors[5],
                  ),
                  const SizedBox(
                      height: 16), // Görseller arasında boşluk bırakıldı
                  EtkinlikSatiri(
                    image1Path: 'assets/images/sayi_oyunu_img/cicek1.png',
                    controller: _controllers[6],
                    fieldColor: _fieldColors[6],
                  ),
                  const SizedBox(
                      height: 16), // Görseller arasında boşluk bırakıldı
                  EtkinlikSatiri(
                    image1Path: 'assets/images/sayi_oyunu_img/cicek2.png',
                    controller: _controllers[7],
                    fieldColor: _fieldColors[7],
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

  const EtkinlikSatiri({
    required this.image1Path,
    required this.controller,
    this.fieldColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EtkinlikFotografi(imagePath: image1Path),
        SizedBox(
          width: 100,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Nesne Sayısı:',
              filled: true,
              fillColor: fieldColor,
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (int.tryParse(value) == null || value.isEmpty) {
                controller.text = '';
              }
            },
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
