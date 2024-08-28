import 'package:flutter/material.dart';
import 'dart:async';


class ColorNamingGame extends StatefulWidget {
  const ColorNamingGame({super.key});

  @override
  _ColorNamingGameState createState() => _ColorNamingGameState();
}

class _ColorNamingGameState extends State<ColorNamingGame> {
  final List<Map<String, dynamic>> colorBoxes = [
    {'color': Colors.orange, 'name': 'turuncu'},
    {'color': Colors.green, 'name': 'yeşil'},
    {'color': Colors.blue, 'name': 'mavi'},
    {'color': Colors.yellow, 'name': 'sarı'},
    {'color': Colors.indigo, 'name': 'lacivert'},
    {'color': Colors.brown, 'name': 'kahverengi'},
  ];

  final Map<int, String> userInputs = {};
  bool showResults = false;
  int correctCount = 0;
  int incorrectCount = 0;

  void checkAnswers() {
    setState(() {
      showResults = true;
      correctCount = 0;
      incorrectCount = 0;
    });

    Timer(const Duration(seconds: 5), () {
      setState(() {
        for (int i = 0; i < colorBoxes.length; i++) {
          if (userInputs[i]?.toLowerCase() != colorBoxes[i]['name']) {
            userInputs[i] = colorBoxes[i]['name'];
            incorrectCount++;
          } else {
            correctCount++;
          }
        }
        showResults = false;
        _showResultDialog();
      });
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sonuçlar"),
          content: Text("Doğru: $correctCount\nYanlış: $incorrectCount"),
          actions: [
            TextButton(
              child: const Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // İki sütun
                  childAspectRatio: 1.0, // Boyut oranını 1.0 yaparak kutuları daha küçük hale getirdik
                  mainAxisSpacing: 4.0, // Kutucuklar arasındaki dikey boşluk
                  crossAxisSpacing: 4.0, // Kutucuklar arasındaki yatay boşluk
                ),
                itemCount: colorBoxes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Container(
                          height: 100, // Kutucukların boyutunu küçülttük
                          color: colorBoxes[index]['color'],
                        ),
                        SizedBox(
                          height: 25, // TextField'in yüksekliğini küçülttük
                          child: TextField(
                            onChanged: (value) {
                              userInputs[index] = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Renk adı',
                              suffixIcon: showResults
                                  ? Icon(
                                userInputs[index]?.toLowerCase() ==
                                    colorBoxes[index]['name']
                                    ? Icons.check
                                    : Icons.close,
                                color: userInputs[index]?.toLowerCase() ==
                                    colorBoxes[index]['name']
                                    ? Colors.green
                                    : Colors.red,
                              )
                                  : null,
                            ),
                          ),
                        ),
                        if (showResults &&
                            userInputs[index]?.toLowerCase() !=
                                colorBoxes[index]['name'])
                          Text(
                            "Doğru: ${colorBoxes[index]['name']}",
                            style: const TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10), // Biraz boşluk ekleyin
            ElevatedButton(
              onPressed: checkAnswers,
              child: const Text('Kontrol Et'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Kutucuğun rengini altına yazın.',
          ),
        ),
      ),
    );
  }
}
