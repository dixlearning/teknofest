import 'package:flutter/material.dart';
import 'package:teknofest/giris_sorulari/sayi_oyunu.dart';

class QuestionModel {
  late String question;
  late String answer;
  late String imageUrl;

  QuestionModel(
      {required this.question, required this.answer, required this.imageUrl});

  void setQuestion(String getQuestion) {
    question = getQuestion;
  }

  void setAnswer(String getAnswer) {
    answer = getAnswer;
  }

  void setImageUrl(String getImageUrl) {
    imageUrl = getImageUrl;
  }

  String getQuestion() {
    return question;
  }

  String getAnswer() {
    return answer;
  }

  String getImageUrl() {
    return imageUrl;
  }
}

List<QuestionModel> getQuestion() {
  List<QuestionModel> questions = [];

  questions.add(QuestionModel(
    question: '_uzdolabı',
    answer: 'b',
    imageUrl: "assets/images/secenekli_oyun_img/buzdolabi1.jpg",
  ));

  questions.add(QuestionModel(
    question: '_üğüm',
    answer: 'd',
    imageUrl: "assets/images/secenekli_oyun_img/dugum1.jpg",
  ));

  questions.add(QuestionModel(
    question: '_ürbün',
    answer: 'd',
    imageUrl: "assets/images/secenekli_oyun_img/durbun1.jpg",
  ));

  questions.add(QuestionModel(
    question: '_ayrak',
    answer: 'b',
    imageUrl: "assets/images/secenekli_oyun_img/bayrak1.jpg",
  ));

  return questions;
}

class QuizPlay extends StatefulWidget {
  const QuizPlay({super.key});

  @override
  State<QuizPlay> createState() => QuizPlayState();
}

class QuizPlayState extends State<QuizPlay>
    with SingleTickerProviderStateMixin {
  List<QuestionModel> _questions = [];
  int index = 0;
  bool isAnswered = false;
  bool isCorrect = false;
  late Animation<double> animation;
  late AnimationController animationController;
  double beginAnim = 0.0;
  double endAnim = 1.0;

  @override
  void initState() {
    super.initState();
    _questions = getQuestion();
    animationController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this)
          ..addListener(() {
            setState(() {});
          });
    animation = Tween<double>(begin: beginAnim, end: endAnim)
        .animate(animationController);
    startAnim();
    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          if (index < _questions.length - 1) {
            index++;
            resetAnim();
            startAnim();
            isAnswered = false; // Cevaplanmadı olarak işaretle
          } else {
            stopAnim(); // Animasyonu durdur
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DiskalkuliEgitimPage(), // Geçiş yapılacak sayfa
              ),
            );
          }
        });
      }
    });
  }

  void startAnim() {
    animationController.forward();
  }

  void resetAnim() {
    animationController.reset();
  }

  void stopAnim() {
    animationController.stop();
  }

  void checkAnswer(String selectedAnswer) {
    setState(() {
      isAnswered = true;
      isCorrect = _questions[index].getAnswer() == selectedAnswer;
    });
    stopAnim();
  }

  void nextQuestion() {
    if (index < _questions.length - 1) {
      setState(() {
        index++;
        resetAnim();
        startAnim();
        isAnswered = false; // Cevaplanmadı olarak işaretle
      });
    } else {
      stopAnim(); // Animasyonu durdur
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiskalkuliEgitimPage(), // Geçiş yapılacak sayfa
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "${index + 1}/${_questions.length}",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Question",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "${_questions[index].question}",
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: animation.value,
            ),
            const SizedBox(height: 20),
            Container(
              height: screenHeight * 0.3,
              width: screenWidth * 0.8,
              child: Image.asset(
                _questions[index].imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
            if (!isAnswered) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () => checkAnswer("b"),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Text(
                            "b",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => checkAnswer("d"),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Text(
                            "d",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Text(
                isCorrect ? "Doğru!" : "Yanlış!",
                style: TextStyle(
                  fontSize: 24,
                  color: isCorrect ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (index < _questions.length - 1) ...[
                ElevatedButton(
                  onPressed: nextQuestion,
                  child: const Text("Sıradaki Soru"),
                ),
              ] else ...[
                ElevatedButton(
                  onPressed: () {
                    // Sorular bittiğinde mat hesaplama ekranına geçiş yap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DiskalkuliEgitimPage(), // Geçiş yapılacak sayfa
                      ),
                    );
                  },
                  child: const Text("Sıradaki Soru"),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
