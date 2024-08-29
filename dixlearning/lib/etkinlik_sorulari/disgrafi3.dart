import 'package:flutter/material.dart';

class CumleOlusturma extends StatefulWidget {
  @override
  _CumleOlusturmaState createState() => _CumleOlusturmaState();
}

class _CumleOlusturmaState extends State<CumleOlusturma> {
  final Map<String, String> sentences = {
    'reçeteye / yazdı / Doktor / ilaç': 'Doktor reçeteye ilaç yazdı',
    'verimli / okumakla / zaman / geçiyor / Dergi':
        'Dergi okumakla zaman verimli geçiyor',
    'Izgaradan / aldı / etleri / maşayla': 'Izgaradan maşayla etleri aldı',
    'Okullar / oldu / tatil / pazartesi': 'Okullar pazartesi tatil oldu',
    'salata / Jale / yaptı / nohutlu': 'Jale nohutlu salata yaptı'
  };

  final Map<String, String> userInputs = {};
  final Map<String, bool?> isCorrect = {};

  @override
  void initState() {
    super.initState();
    sentences.forEach((key, value) {
      userInputs[key] = '';
      isCorrect[key] = null; // Başlangıçta null, doğru/yanlış değil
    });
  }

  void checkAnswer(String sentence) {
    setState(() {
      isCorrect[sentence] = userInputs[sentence]?.trim().toLowerCase() ==
          sentences[sentence]!.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cümle Oluşturma')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Karışık verilen sözcüklerden anlamlı cümle oluşturalım.'),
            const SizedBox(height: 20),
            ...sentences.keys.map((sentence) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sentence),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        userInputs[sentence] = text;
                      });
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: isCorrect[sentence] == true
                          ? Colors.green[50]
                          : isCorrect[sentence] == false
                              ? Colors.red[50]
                              : Colors.white,
                      hintText: 'Cümleyi buraya yazınız',
                    ),
                    style: TextStyle(
                      color: isCorrect[sentence] == true
                          ? Colors.green
                          : isCorrect[sentence] == false
                              ? Colors.red
                              : Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      checkAnswer(sentence);
                    },
                    child: Text('Kontrol Et'),
                  ),
                  if (isCorrect[sentence] == false)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Doğru cevap: ${sentences[sentence]}',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  SizedBox(height: 20),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
