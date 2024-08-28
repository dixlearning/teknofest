import 'package:flutter/material.dart';



class DyslexiaActivityPage extends StatefulWidget {
  const DyslexiaActivityPage({super.key});

  @override
  _DyslexiaActivityPageState createState() => _DyslexiaActivityPageState();
}


class _DyslexiaActivityPageState extends State<DyslexiaActivityPage> {
  final List<List<String>> letters = [
    ['m', 'n', 'u', 'm', 'n'],
    ['n', 'u', 'm', 'n', 'u'],
    ['m', 'n', 'u', 'm', 'n'],
    ['n', 'm', 'u', 'n', 'm'],
    ['u', 'm', 'n', 'u', 'm'],
    ['m', 'n', 'u', 'm', 'n'],
    ['n', 'u', 'm', 'n', 'u'],
  ];


  List<List<bool>> selected = List.generate(7, (_) => List.generate(5, (_) => false));


  int selectedCount = 0;
  late int totalUCount;


  @override
  void initState() {
    super.initState();
    totalUCount = letters.expand((row) => row).where((letter) => letter == 'u').length;
  }


  void _checkSelection() {
    int selectedUCount = 0;
    for (int i = 0; i < letters.length; i++) {
      for (int j = 0; j < letters[i].length; j++) {
        if (letters[i][j] == 'u' && selected[i][j]) {
          selectedUCount++;
        }
      }
    }
    setState(() {
      selectedCount = selectedUCount;
    });


    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sonuç'),
          content: Text('Seçilen \'u\' harfi sayısı: $selectedCount\n Kalan \'u\' harfi sayısı: ${totalUCount - selectedCount}'),
          actions: [
            TextButton(
              child: const Text('Tamam'),
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
        title: const Text("'u' harfini bul ve maviye boya."),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemCount: 35, // 7 * 5 = 35
              itemBuilder: (context, index) {
                int row = index ~/ 5;
                int col = index % 5;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (letters[row][col] == 'u') {
                        selected[row][col] = !selected[row][col];
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: selected[row][col] ? Colors.blue : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        letters[row][col],
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _checkSelection,
            child: const Text('Kontrol Et'),
          ),
        ],
      ),
    );
  }}