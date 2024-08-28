import 'package:flutter/material.dart';


class CountingGame extends StatefulWidget {
  const CountingGame({super.key});

  @override
  _CountingGameState createState() => _CountingGameState();
}

class _CountingGameState extends State<CountingGame> {
  final List<List<int>> numbers = [
    [9, 2, 3, 2, 0, 7, 2, 3, 8, 2, 1, 2, 2],
    [3, 1, 9, 1, 4, 7, 1, 8, 1, 0, 5, 1, 6],
    [2, 3, 4, 3, 3, 6, 3, 8, 9, 3, 1, 7, 3],
    [5, 4, 0, 4, 2, 4, 1, 8, 4, 9, 4, 7, 1],
    [9, 5, 5, 2, 4, 5, 6, 3, 0, 2, 7, 2, 1],
    [1, 6, 6, 2, 7, 6, 4, 9, 6, 3, 6, 8, 4],
    [7, 1, 3, 5, 0, 1, 2, 5, 0, 8, 1, 4, 3],
  ];

  final Map<int, TextEditingController> controllers = {
    0: TextEditingController(),
    1: TextEditingController(),
    2: TextEditingController(),
    3: TextEditingController(),
    4: TextEditingController(),
    5: TextEditingController(),
    6: TextEditingController(),
    7: TextEditingController(),
    8: TextEditingController(),
    9: TextEditingController(),
  };

  @override
  void dispose() {
    controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _checkAnswers() {
    Map<int, int> counts = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0, 9: 0};

    for (var row in numbers) {
      for (var num in row) {
        counts[num] = counts[num]! + 1;
      }
    }

    bool isCorrect = true;

    counts.forEach((num, count) {
      if (controllers[num]!.text != count.toString()) {
        isCorrect = false;
      }
    });

    if (isCorrect) {
      _showDialog('TEBRİKLER!', 'Tüm sayıları doğru saydınız.');
    } else {
      _showDialog('YANLIŞ!', 'Lütfen sayıları tekrar kontrol edin.');
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text('Tamam'),
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
      appBar: AppBar(
        title: Text('Sayı Sayma Oyunu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tabloda yer alan sayıların her biri için kaç tane olduğunu aşağıdaki kutucuklara yazınız.',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      numbers.length,
                          (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          '${numbers[index].join(' - ')}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      10,
                          (index) => Expanded(
                        child: Column(
                          children: [
                            Text(index.toString()),
                            Container(
                              width: double.infinity,
                              height: 40,
                              margin: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: Colors.red[300],
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: TextField(
                                controller: controllers[index],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.red[200],
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(8.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: _checkAnswers,
                child: Text('Kontrol Et'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
