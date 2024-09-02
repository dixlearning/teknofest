import 'package:flutter/material.dart';
import 'package:teknofest/giris_sorulari/ilk_harf.dart';
import 'package:teknofest/other_functions/game_manager.dart';

class HomePage2 extends StatefulWidget {
  HomePage2({super.key, required this.question});
  late Question question;
  @override
  _HomePageState createState() => _HomePageState(question: question);
}

class _HomePageState extends State<HomePage2> {
  _HomePageState({required this.question});
  late Question question;

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
      List.filled(5, const Color.fromARGB(255, 255, 255, 255));
  List<Color> resultColors = List.filled(5, Colors.black);
  List<bool> disabled = List.filled(5, false);

  int correctCount = 0;
  int wrongCount = 0;
  bool gameEnded = false;
  GameManager _gameManager = GameManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Hoş Geldin Testi!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Tahtanın üzerinde bulunan işlemleri yapalım!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
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
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              decoration: disabled[index]
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                            textAlign: TextAlign.center,
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
              color: Colors.grey.shade300,
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
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
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
                          style:
                              const TextStyle(color: Colors.red, fontSize: 18),
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
                            fontWeight: FontWeight.bold,
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    'Toplam Yanlış: $wrongCount',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
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
                        Future.delayed(const Duration(seconds: 2), () {
                          _handleGameEnd();
                        });
                      });
                    },
              child: const Text('Oyunu Bitir'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleGameEnd() async {
    question.TrueResult = correctCount;
    question.FalseResult = wrongCount;
    await _gameManager.setGame(context, question);
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
        Future.delayed(const Duration(seconds: 2), () {
          _handleGameEnd();
        });
      });
    }
  }
}
