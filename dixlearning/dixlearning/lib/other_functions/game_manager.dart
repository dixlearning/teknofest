import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teknofest/main.dart';
import 'package:teknofest/other_functions/MessageHandler.dart';
import 'package:teknofest/screens/dashboard.dart';

//Bu sınıf, oyunları rastgele sırayla sunacak ve oyunlar bittiğinde kullanıcıyı ilgili ekrana yönlendirecek.
class Question {
  String? Route;
  int? Category;
  int? Id;
  int? TrueResult;
  int? FalseResult;
  Question({
    this.Id,
    this.Route,
    this.Category,
    this.TrueResult,
    this.FalseResult,
  });
}

class RequestCategorySuccessRate {
  String? userId;
  int? categoryId;
  double? successRate;

  RequestCategorySuccessRate({this.userId, this.categoryId, this.successRate});

  RequestCategorySuccessRate.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    categoryId = json['category_id'];
    successRate = json['success_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['success_rate'] = this.successRate;
    return data;
  }
}

class QuestionRequest {
  String? userId;
  int? questionId;
  int? status;

  QuestionRequest({this.userId, this.questionId, this.status});

  QuestionRequest.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    questionId = json['questionId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['questionId'] = this.questionId;
    data['status'] = this.status;
    return data;
  }
}

class GameManager {
  final List<Question> oyunlar = [
    Question(Id: 1, Route: "giris_sorulari/bd_sorusu", Category: 2),
    Question(Id: 2, Route: "giris_sorulari/eksik_hece", Category: 0),
    Question(
        Id: 3,
        Route: "giris_sorulari/giris_harf_eslestir_disleksi",
        Category: 2),
    Question(Id: 4, Route: "giris_sorulari/golge_oyunu", Category: 1),
    Question(Id: 5, Route: "giris_sorulari/gorsel_adi", Category: 0),
    Question(Id: 6, Route: "giris_sorulari/ilk_harf", Category: 2),
    Question(Id: 7, Route: "giris_sorulari/mat_hesaplama", Category: 1),
    Question(Id: 8, Route: "giris_sorulari/renk_sorusu", Category: 0),
    Question(Id: 9, Route: "giris_sorulari/sayi_oyunu", Category: 1),
  ];

  List<Question> _remainingGames = [];

  GameManager() {
    _remainingGames = List.from(oyunlar);
    _remainingGames.shuffle(Random());
  }

  void removeRemainingElement(ResultQuestion question) {
    for (int i = 0; i < _remainingGames.length; i++) {
      if (_remainingGames[i].Id == question.questionId)
        _remainingGames.remove(_remainingGames[i]);
    }
    if (_remainingGames.length == 0) _remainingGames = [];
  }

  Future<Question?> getNextGame() async {
    await getUserGames();
    if (_remainingGames.isEmpty) return null;
    return _remainingGames.removeAt(0);
  }

  Future<String?> setGame(BuildContext context, Question question) async {
    double ResultRate = 0;
    double questionRate = CalculateQuestionRate(question);

    ResultRate =
        (questionRate / (question.TrueResult! + question.FalseResult!)) *
            question.TrueResult!;
    String? Id = supabase.auth.currentUser!.id;
    RequestCategorySuccessRate successRate = RequestCategorySuccessRate(
        userId: Id, categoryId: question.Category, successRate: ResultRate);
    print(successRate.userId);
    print(successRate.categoryId);
    print(successRate.successRate);

    try {
      final resultRateData = await supabase
          .from("Rates")
          .select()
          .match({'user_id': Id, 'category_id': question.Category!});

      if (resultRateData.length > 0) {
        RequestCategorySuccessRate rates =
            RequestCategorySuccessRate.fromJson(resultRateData[0]);
        print("Result Current Rate: ${rates.successRate}");
        rates.successRate = rates.successRate! + ResultRate;
        final data = await supabase
            .from("Rates")
            .update(rates.toJson())
            .match({'user_id': Id, 'category_id': question.Category!});
      } else {
        final dataN =
            await supabase.from("Rates").insert([successRate.toJson()]);
      }

      QuestionRequest request =
          QuestionRequest(userId: Id, questionId: question.Id, status: 1);
      await supabase.from("User_Questions").insert(request);

      Question? nextQuestion = await getNextGame();

      if (nextQuestion == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        Navigator.pushNamed(context, nextQuestion.Route!);
      }
    } catch (e) {
      print(e);
    }
  }

  double CalculateQuestionRate(Question question) {
    double rate = 0;
    double maxRate = 100;
    for (int i = 0; i < oyunlar.length; i++) {
      if (question.Category == oyunlar[i].Category) {
        rate += 1;
      }
    }
    return maxRate / rate;
  }

  Future<String?> getUserGames() async {
    final data = await supabase
        .from("User_Questions")
        .select()
        .eq('user_id', supabase.auth.currentUser!.id);
    List<ResultQuestion> games = [];
    for (int i = 0; i < data.length; i++) {
      games.add(ResultQuestion.fromJson(data[i]));
      removeRemainingElement(games[i]);
    }
  }

  bool hasMoreGames() => _remainingGames.isNotEmpty;
}
