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
      isCorrect[key] = null;
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
      appBar: AppBar(
        title: const Text('Cümle Kuralım!'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.teal[50],
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Karışık verilen sözcükler ile anlamlı cümleler oluşturalım.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),
              ...sentences.keys.map((sentence) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sentence,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          userInputs[sentence] = text;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: isCorrect[sentence] == true
                            ? Colors.green[50]
                            : isCorrect[sentence] == false
                                ? Colors.red[50]
                                : Colors.white,
                        hintText: 'Cümleyi buraya yazınız...',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        color: isCorrect[sentence] == true
                            ? Colors.green
                            : isCorrect[sentence] == false
                                ? Colors.red
                                : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        checkAnswer(sentence);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Kontrol Et!',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    if (isCorrect[sentence] == false)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Doğru cevap: ${sentences[sentence]}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
