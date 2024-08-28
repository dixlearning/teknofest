import 'package:flutter/material.dart';
import 'package:teknofest/giris_sorulari/ilk_harf.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  List<Map<String, dynamic>> equations = [
    {'equation': '1 + ? = 4', 'result': 3},
    {'equation': '2 x ? = 10', 'result': 5},
    {'equation': '3 + ? = 5', 'result': 2},
    {'equation': '9 - ? = 3', 'result': 6},
    {'equation': '7 + ? = 11', 'result': 4},
  ];

  List<int> results = [3, 5, 2, 6, 4];
  List<bool> matched = List.filled(5, false);
  List<Color> equationColors =
      List.filled(5, const Color.fromARGB(255, 223, 4, 4));
  List<Color> resultColors =
      List.filled(5, const Color.fromARGB(255, 225, 7, 7));
  List<bool> disabled = List.filled(5, false);

  int correctCount = 0;
  int wrongCount = 0;
  bool gameEnded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matematik Oyunu'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: equations.length,
              itemBuilder: (context, index) {
                return DragTarget<int>(
                  builder: (
                    BuildContext context,
                    List<int?> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/mat_hesaplama_img/tahta.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          equations[index]['equation'],
                          style: TextStyle(
                            color: equationColors[index],
                            fontSize: 18,
                            decoration: disabled[index]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                      height: 50,
                      width: 100,
                    );
                  },
                  onWillAcceptWithDetails: (details) {
                    return !disabled[index];
                  },
                  onAcceptWithDetails: (details) {
                    int receivedData = details.data as int;
                    if (!disabled[index]) {
                      setState(() {
                        if (receivedData == equations[index]['result']) {
                          matched[index] = true;
                          equationColors[index] = Colors.green;
                          correctCount++;
                        } else {
                          equationColors[index] = Colors.red;
                          wrongCount++;
                        }
                        disabled[index] = true;
                        checkGameEnd();
                      });
                    }
                  },
                );
              },
            ),
          ),
          Container(
            height: 100,
            color: const Color.fromARGB(68, 194, 81, 196),
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: results.length,
              itemBuilder: (context, index) {
                return Draggable<int>(
                  data: results[index],
                  feedback: Material(
                    color: Colors.transparent,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/mat_hesaplama_img/box.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          results[index].toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 176, 25, 25),
                              fontSize: 18),
                        ),
                      ),
                      height: 50,
                      width: 100,
                    ),
                  ),
                  childWhenDragging: Container(
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        results[index].toString(),
                        style: const TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    ),
                    height: 50,
                    width: 100,
                  ),
                  feedbackOffset: const Offset(0, -30),
                  onDragCompleted: () {
                    setState(() {
                      resultColors[index] =
                          const Color.fromARGB(255, 0, 190, 232);
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/mat_hesaplama_img/box.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        results[index].toString(),
                        style: TextStyle(
                          color: resultColors[index],
                          fontSize: 18,
                          decoration: matched.contains(true)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                    height: 50,
                    width: 100,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Visibility(
            visible: gameEnded,
            child: Column(
              children: [
                Text(
                  'Toplam Doğru: $correctCount',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Toplam Yanlış: $wrongCount',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: gameEnded
                ? null
                : () {
                    setState(() {
                      gameEnded = true;
                      // Skoru gösterdikten sonra yeni bir oyuna geçiş yap
                      Future.delayed(const Duration(seconds: 2), () {
                        _handleGameEnd();
                      });
                    });
                  },
            child: const Text('Oyunu Bitir'),
          ),
        ],
      ),
    );
  }

  void _handleGameEnd() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const FillMissingLetter()), // IlkHarf sayfanızı buraya ekleyin
    );
  }

  void checkGameEnd() {
    bool allMatched = true;
    for (int i = 0; i < matched.length; i++) {
      if (!matched[i]) {
        allMatched = false;
        break;
      }
    }
    if (allMatched) {
      setState(() {
        gameEnded = true;
        // Skoru gösterdikten sonra yeni bir oyuna geçiş yap
        Future.delayed(const Duration(seconds: 2), () {
          _handleGameEnd();
        });
      });
    }
  }
}
