import 'package:flutter/material.dart';

class PoemPage extends StatefulWidget {
  const PoemPage({super.key});

  @override
  _PoemPageState createState() => _PoemPageState();
}

class _PoemPageState extends State<PoemPage> {
  final _poemController = TextEditingController();
  String _resultMessage = '';
  Color _resultColor = Colors.red;

  String normalizeText(String text) {
    return text.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  void _checkPoem() {
    const correctPoem =
        'Bir hafta yedi gündür\nSöyleyelim bilelim\nHaydi hep birlikte\nTekrarlayıp öğrenelim\n\nPazartesi salı çarşamba\nHerkes kendi işinde\nPerşembe ve cuma\nYorulduk mu ne?\n\nCumartesi ve pazar\nHaftasonu günleri\nHep beraber sayalım\nHaftanın günlerini';

    final userPoem = _poemController.text;

    if (normalizeText(userPoem) == normalizeText(correctPoem)) {
      setState(() {
        _resultMessage = 'Harika! Doğru yazdın!';
        _resultColor = Colors.green;
      });
    } else {
      setState(() {
        _resultMessage = 'Üzgünüm, yanlış cevap. Hadi tekrar deneyelim!';
        _resultColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Birlikte Şiir Yazalım!'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.teal[50],
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Aşağıda verilen şiirin aynısını bırakılan boşluğa yazalım.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Colors.teal,
              ),
              textAlign: TextAlign.justify, // Correctly placed textAlign
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.teal.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: const Text(
                          'Bir hafta yedi gündür\nSöyleyelim bilelim\nHaydi hep birlikte\nTekrarlayıp öğrenelim\n\nPazartesi salı çarşamba\nHerkes kendi işinde\nPerşembe ve cuma\nYorulduk mu ne?\n\nCumartesi ve pazar\nHaftasonu günleri\nHep beraber sayalım\nHaftanın günlerini',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: _poemController,
                        maxLines: null,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Şiiri buraya yazınız...',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkPoem,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Kontrol Et',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _resultMessage,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _resultColor,
              ),
              textAlign: TextAlign.center, // Correctly placed textAlign
            ),
          ],
        ),
      ),
    );
  }
}
