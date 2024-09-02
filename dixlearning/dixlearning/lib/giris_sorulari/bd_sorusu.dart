import 'package:flutter/material.dart';
import 'package:teknofest/giris_sorulari/sayi_oyunu.dart';
import 'package:teknofest/other_functions/game_manager.dart';

class QuestionModel {
  late String question;
  late String answer;
  late String imageUrl;

  QuestionModel({
    required this.question,
    required this.answer,
    required this.imageUrl,
  });

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
  QuizPlay({super.key, required this.question});
  late Question question;
  @override
  State<QuizPlay> createState() => QuizPlayState(question: question);
}

class QuizPlayState extends State<QuizPlay>
    with SingleTickerProviderStateMixin {
  QuizPlayState({required this.question});
  List<QuestionModel> _questions = [];
  int index = 0;
  bool isAnswered = false;
  bool isCorrect = false;
  late Animation<double> animation;
  late AnimationController animationController;
  double beginAnim = 0.0;
  double endAnim = 1.0;
  late Question question;
  int correctAnswer = 0;
  int incorrectAnswer = 0;
  GameManager _gameManager = GameManager();
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
        setState(() async {
          if (index < _questions.length - 1) {
            index++;
            resetAnim();
            startAnim();
            isAnswered = false;
            print("next*1");
          } else {
            stopAnim();
            question.TrueResult = correctAnswer;
            question.FalseResult = incorrectAnswer;
            await _gameManager.setGame(context, question);
            print("next");
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
      if (isCorrect) {
        correctAnswer++;
      } else {
        incorrectAnswer++;
      }
    });
    stopAnim();
  }

  void nextQuestion() async {
    if (index < _questions.length - 1) {
      setState(() {
        index++;
        resetAnim();
        startAnim();
        isAnswered = false;
      });
    } else {
      stopAnim();
      question.TrueResult = correctAnswer;
      question.FalseResult = incorrectAnswer;
      await _gameManager.setGame(context, question);
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            const Text(
              "Verilen boşluğu doğru harf ile tamamlayalım.",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Text(
              _questions[index].question,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: animation.value,
              backgroundColor: Colors.grey.shade300,
              color: Colors.blue,
            ),
            const SizedBox(height: 40),
            Center(
              child: Container(
                height: screenHeight * 0.3,
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    _questions[index].imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Spacer(),
            if (!isAnswered) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => checkAnswer("b"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 32),
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text("b"),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => checkAnswer("d"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 32),
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text("d"),
                  ),
                ],
              ),
            ] else ...[
              Text(
                "Cevap: ${_questions[index].getQuestion().replaceAll('_', _questions[index].getAnswer())}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                isCorrect ? "Doğru Cevap!" : "Lütfen Dikkatli Ol!",
                style: TextStyle(
                  fontSize: 25,
                  color: isCorrect ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: nextQuestion,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  index < _questions.length - 1 ? "Sıradaki Soru" : "Bitir",
                ),
              ),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
