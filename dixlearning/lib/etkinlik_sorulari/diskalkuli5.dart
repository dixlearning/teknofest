import 'package:flutter/material.dart';

class YansimaIsaretlemeOyunu extends StatefulWidget {
  const YansimaIsaretlemeOyunu({super.key});

  @override
  _YansimaIsaretlemeOyunuState createState() => _YansimaIsaretlemeOyunuState();
}

class _YansimaIsaretlemeOyunuState extends State<YansimaIsaretlemeOyunu> {
  final List<List<List<bool>>> leftGrids = [
    [
      [true, false, false],
      [false, true, false],
      [false, false, true],
    ],
    [
      [false, false, true],
      [false, true, false],
      [true, false, false],
    ],
    [
      [false, false, true],
      [false, true, false],
      [false, true, false],
    ],
    [
      [true, false, false],
      [false, true, false],
      [true, false, false],
    ],
  ];

  final List<List<List<bool>>> rightGrids = List.generate(
    4,
    (_) => List.generate(3, (index) => List.generate(3, (index) => false)),
  );

  void onRightCellTap(int gridIndex, int row, int col) {
    setState(() {
      rightGrids[gridIndex][row][col] = !rightGrids[gridIndex][row][col];
    });
  }

  void checkReflection() {
    List<bool> isCorrect = [
      _checkGridReflection(leftGrids[0], rightGrids[0]),
      _checkGridReflection(leftGrids[1], rightGrids[1]),
      _checkGridReflection(leftGrids[2], rightGrids[2]),
      _checkGridReflection(leftGrids[3], rightGrids[3]),
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sonuç'),
          content: Text(isCorrect.every((correct) => correct)
              ? 'Harika! Hepsi Doğru'
              : 'Üzgünüm,yanlış veya eksik cevap.\nHadi Tekrar Deneyelim!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  bool _checkGridReflection(
      List<List<bool>> leftGrid, List<List<bool>> rightGrid) {
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (leftGrid[row][col] != rightGrid[row][2 - col]) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doğru Yansımayı Bulalım!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Verilen şekillerin yansımasını kutucuklara işaretleyelim.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "ŞEKİL",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12, // Font boyutunu biraz arttırdım
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: 10), // Arayı biraz genişlettim
                          Expanded(
                            child: Text(
                              "SİMETRİSİ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12, // Font boyutunu biraz arttırdım
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GridWidget(
                              gridState: leftGrids[index],
                              isLeftGrid: true,
                              onCellTap: (row, col) {},
                            ),
                          ),
                          SizedBox(width: 10), // Arayı biraz genişlettim
                          Container(
                            width: 2,
                            height: 90,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10), // Arayı biraz genişlettim
                          Expanded(
                            child: GridWidget(
                              gridState: rightGrids[index],
                              isLeftGrid: false,
                              onCellTap: (row, col) =>
                                  onRightCellTap(index, row, col),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkReflection,
              child: Text('Kontrol Et'),
            ),
          ],
        ),
      ),
    );
  }
}

class GridWidget extends StatelessWidget {
  final List<List<bool>> gridState;
  final bool isLeftGrid;
  final Function(int, int) onCellTap;

  GridWidget({
    required this.gridState,
    required this.isLeftGrid,
    required this.onCellTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        children: List.generate(3, (row) {
          return Expanded(
            child: Row(
              children: List.generate(3, (col) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onCellTap(row, col),
                    child: Container(
                      margin: EdgeInsets.all(0.5),
                      decoration: BoxDecoration(
                        color: gridState[row][col]
                            ? (isLeftGrid ? Colors.blue[500] : Colors.blue[200])
                            : Colors.grey[300],
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}
