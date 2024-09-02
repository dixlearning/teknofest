import 'package:flutter/material.dart';
import 'package:teknofest/giris_sorulari/bd_sorusu.dart';
import 'package:teknofest/other_functions/game_manager.dart'; // BD Sorusu sayfasının importu

class ColorNamingGame extends StatefulWidget {
  ColorNamingGame({super.key, required this.question});
  late Question question;

  @override
  _ColorNamingGameState createState() =>
      _ColorNamingGameState(question: question);
}

class _ColorNamingGameState extends State<ColorNamingGame> {
  _ColorNamingGameState({required this.question});
  late Question question;
  final List<Map<String, dynamic>> colorBoxes = [
    {'color': Colors.orange, 'name': 'turuncu'},
    {'color': Colors.green, 'name': 'yeşil'},
    {'color': Colors.blue, 'name': 'mavi'},
    {'color': Colors.yellow, 'name': 'sarı'},
    {'color': Colors.pink, 'name': 'pembe'},
    {'color': Colors.brown, 'name': 'kahverengi'},
  ];

  final Map<int, String> userInputs = {};
  final Map<int, bool> checked = {};
  bool showResults = false;
  int correctCount = 0;
  int incorrectCount = 0;
  GameManager _gameManager = GameManager();
  @override
  void initState() {
    super.initState();
    // Initialize the checked map
    for (int i = 0; i < colorBoxes.length; i++) {
      checked[i] = false;
    }
  }

  void checkAnswer(int index) {
    setState(() {
      // Girilen değerin küçük harfe çevrilmiş hali ile karşılaştırma yapılır
      if (userInputs[index]?.trim().toLowerCase() ==
          colorBoxes[index]['name']) {
        correctCount++;
      } else {
        incorrectCount++;
      }
      checked[index] = true;
      showResults = true;
    });
    question.TrueResult = correctCount;
    question.FalseResult = incorrectCount;
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sonuçlar:"),
          content: Text("Doğru: $correctCount\nYanlış: $incorrectCount"),
          actions: [
            TextButton(
              child: const Text("Tamam"),
              onPressed: () async {
                print("SetGamee");
                await _gameManager.setGame(context, question);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Kutuların rengini verilen boşluğa yaz.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // İki sütun
                  childAspectRatio:
                      1.0, // Boyut oranını 1.0 yaparak kutuları daha küçük hale getirdik
                  mainAxisSpacing: 4.0, // Kutucuklar arasındaki dikey boşluk
                  crossAxisSpacing: 4.0, // Kutucuklar arasındaki yatay boşluk
                ),
                itemCount: colorBoxes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 70, // Kutucuk yüksekliği
                          width: 120, // Kutucuk genişliği
                          color: colorBoxes[index]['color'],
                        ),
                        const SizedBox(
                            height:
                                8), // TextField ve kutucuklar arasında boşluk
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              userInputs[index] = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Renk adı',
                              suffixIcon: showResults && checked[index] == true
                                  ? Icon(
                                      userInputs[index]?.trim().toLowerCase() ==
                                              colorBoxes[index]['name']
                                          ? Icons.check
                                          : Icons.close,
                                      color: userInputs[index]
                                                  ?.trim()
                                                  .toLowerCase() ==
                                              colorBoxes[index]['name']
                                          ? Colors.green
                                          : Colors.red,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        if (showResults && checked[index]!)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              userInputs[index]?.trim().toLowerCase() ==
                                      colorBoxes[index]['name']
                                  ? "Doğru!"
                                  : "Doğru: ${colorBoxes[index]['name']}",
                              style: TextStyle(
                                color:
                                    userInputs[index]?.trim().toLowerCase() ==
                                            colorBoxes[index]['name']
                                        ? Colors.green
                                        : Colors.red,
                              ),
                            ),
                          ),
                        ElevatedButton(
                          onPressed: checked[index] == true
                              ? null
                              : () => checkAnswer(index),
                          child: const Text('Kontrol Et!'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10), // Biraz boşluk ekleyin
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (checked.values.every((value) => value)) {
                    _showResultDialog();
                  }
                },
                child: const Text('Sonuçları Göster!'),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[400],
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Hoş Geldin Testi!',
          ),
        ),
      ),
    );
  }
}
