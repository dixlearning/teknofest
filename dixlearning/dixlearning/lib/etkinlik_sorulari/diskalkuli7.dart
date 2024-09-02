import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PuzzleGameScreen extends StatefulWidget {
  const PuzzleGameScreen({super.key});

  @override
  _PuzzleGameScreenState createState() => _PuzzleGameScreenState();
}

class _PuzzleGameScreenState extends State<PuzzleGameScreen> {
  List<List<int?>> rows = [
    [2, null, 5, 4, null, 9, 0, 7, null, 8],
    [null, 1, null, 3, null, 7, 6, 9, null, 5],
    [4, null, 2, null, 8, null, 6, null, 9, 0],
    [6, 4, 5, 3, 1, 2, null, 8, null, null],
    [null, 9, null, 7, null, 0, 5, null, 3],
  ];

  late List<List<Color>> boxColors;

  @override
  void initState() {
    super.initState();
    boxColors = List.generate(
        rows.length, (_) => List.generate(10, (_) => Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıp Rakamları Bulalım!'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Her satırı 0\'dan 9\'a kadar yerleştirelim. Eksik bırakılan rakamları boş kutulara dolduralım.',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 18, 46, 202)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            for (int i = 0; i < rows.length; i++) ...[
              Row(
                children: [
                  for (int j = 0; j < rows[i].length; j++)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: boxColors[i][j],
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DragTarget<int>(
                            onAccept: (receivedItem) {
                              setState(() {
                                int? currentValue = rows[i][j];
                                int oldIndex = rows[i].indexOf(receivedItem);

                                if (currentValue == null) {
                                  rows[i][j] = receivedItem;
                                  rows[i][oldIndex] = null;
                                } else {
                                  rows[i][oldIndex] = currentValue;
                                  rows[i][j] = receivedItem;
                                }
                              });
                            },
                            builder: (context, candidateData, rejectedData) {
                              return Center(
                                child: rows[i][j] == null
                                    ? TextField(
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            int? number = int.tryParse(value);
                                            setState(() {
                                              rows[i][j] = number;
                                            });
                                          }
                                        },
                                      )
                                    : Draggable<int>(
                                        data: rows[i][j]!,
                                        feedback: Material(
                                          color: Colors.transparent,
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            color: Colors.blue,
                                            child: Center(
                                              child: Text(
                                                '${rows[i][j]}',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        childWhenDragging: Container(),
                                        child: Text(
                                          '${rows[i][j]}',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20), // Satırlar arasında boşluk
            ],
            ElevatedButton(
              onPressed: _checkResults,
              child: const Text('Kontrol Et'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _retryIncorrectRows,
              child: const Text('Tekrar Dene'),
            ),
          ],
        ),
      ),
    );
  }

  void _checkResults() {
    setState(() {
      for (int i = 0; i < rows.length; i++) {
        bool correct = true;
        List<int> sortedRow =
            List<int>.from(rows[i].where((item) => item != null).cast<int>())
              ..sort();
        for (int j = 0; j < sortedRow.length; j++) {
          if (sortedRow[j] != j) {
            correct = false;
            break;
          }
        }
        for (int j = 0; j < rows[i].length; j++) {
          boxColors[i][j] = correct ? Colors.green : Colors.red;
        }
      }
    });
  }

  void _retryIncorrectRows() {
    setState(() {
      for (int i = 0; i < rows.length; i++) {
        bool correct = true;
        List<int> sortedRow =
            List<int>.from(rows[i].where((item) => item != null).cast<int>())
              ..sort();
        for (int j = 0; j < sortedRow.length; j++) {
          if (sortedRow[j] != j) {
            correct = false;
            break;
          }
        }
        if (!correct) {
          for (int j = 0; j < rows[i].length; j++) {
            rows[i][j] = null; // Yanlış satırları sıfırla
            boxColors[i][j] = Colors.white; // Renkleri sıfırla
          }
        }
      }
    });
  }
}
