import 'package:flutter/material.dart';


class PoemPage extends StatefulWidget {
  const PoemPage({super.key});

 @override
 _PoemPageState createState() => _PoemPageState();
}

class _PoemPageState extends State<PoemPage> {
 final _poemController = TextEditingController();
 String _resultMessage = '';
 Color _resultColor = Colors.red; // Varsayılan renk kırmızı

 String normalizeText(String text) {
  return text
      .toLowerCase()
      .replaceAll(RegExp(r'\s+'), ' ')  // Birden fazla boşluğu tek boşlukla değiştirir
      .trim();
 }

 void _checkPoem() {
  const correctPoem = 'Bir hafta yedi gündür\nSöyleyelim bilelim\nHaydi hep birlikte\nTekrarlayıp öğrenelim\n\nPazartesi salı çarşamba\nHerkes kendi işinde\nPerşembe ve cuma\nYorulduk mu ne\n\nCumartesi ve pazar\nHafta sonu günleri\nHep beraber sayalım\nHaftanın günlerini';

  final userPoem = _poemController.text;

  if (normalizeText(userPoem) == normalizeText(correctPoem)) {
   setState(() {
    _resultMessage = 'Doğru yazdınız!';
    _resultColor = Colors.green; // Doğruysa yeşil renk
   });
  } else {
   setState(() {
    _resultMessage = 'Hatalı yazdınız, tekrar deneyin.';
    _resultColor = Colors.red; // Yanlışsa kırmızı renk
   });
  }
 }

 @override
 Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(
    title: const Text('Şiir Yazma Uygulaması'),
   ),
   body: Container(
    color: Colors.yellow[200], // Arka plan koyu sarı
    padding: const EdgeInsets.all(16.0),
    child: Column(
     children: <Widget>[
      const Text(
       'Aşağıdaki şiirin aynısını yazınız.',
       style: TextStyle(fontSize: 20),
      ),
      const SizedBox(height: 16),
      Expanded(
       child: Row(
        children: <Widget>[
         Expanded(
          flex: 1,
          child: SingleChildScrollView(
           child: Container(
            color: Colors.yellow[100], // Şiir kutusu açık sarı
            padding: const EdgeInsets.all(8),
            child: const Text(
             'Bir hafta yedi gündür\nSöyleyelim bilelim\nHaydi hep birlikte\nTekrarlayıp öğrenelim\n\nPazartesi salı çarşamba\nHerkes kendi işinde\nPerşembe ve cuma\nYorulduk mu ne\n\nCumartesi ve pazar\nHafta sonu günleri\nHep beraber sayalım\nHaftanın günlerini',
             style: TextStyle(fontSize: 16),
            ),
           ),
          ),
         ),
         const SizedBox(width: 16),
         Expanded(
          flex: 1,
          child: Container(
           color: Colors.yellow[100], // Şiir kutusu açık sarı
           padding: const EdgeInsets.all(8),
           child: TextField(
            controller: _poemController,
            maxLines: null,
            decoration: const InputDecoration(
             border: OutlineInputBorder(),
             hintText: 'Şiiri buraya yazınız...',
            ),
           ),
          ),
         ),
        ],
       ),
      ),
      const SizedBox(height: 16),
      ElevatedButton(
       onPressed: _checkPoem,
       child: const Text('Kontrol Et'),
      ),
      const SizedBox(height: 16),
      Text(
       _resultMessage,
       style: TextStyle(fontSize: 18, color: _resultColor),
      ),
     ],
    ),
   ),
  );
 }
}
