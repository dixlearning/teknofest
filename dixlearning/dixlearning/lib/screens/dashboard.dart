import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teknofest/main.dart';
import 'package:teknofest/other_functions/game_manager.dart';
import 'package:teknofest/screens/ProfilePage.dart';
import 'package:teknofest/screens/questionLisr.dart';
import 'package:teknofest/screens/registiration_screen.dart';

class QuesionToCategory {
  int? id;
  String? route;
  int? category;
  QuesionToCategory(
      {required this.id, required this.route, required this.category});
}

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardWidget();
  }
}

class DashboardWidget extends State<StatefulWidget> {
  final List<QuesionToCategory> etkinlikOyunlari = [
    QuesionToCategory(id: 7, route: "Disgrafi Soru 1", category: 0),
    QuesionToCategory(id: 8, route: "Disgrafi Soru 2", category: 0),
    QuesionToCategory(id: 9, route: "Disgrafi Soru 3", category: 0),
    QuesionToCategory(id: 10, route: "Disgrafi Soru 4", category: 0),
    QuesionToCategory(id: 11, route: "Disgrafi Soru 5", category: 0),
    QuesionToCategory(id: 12, route: "Diskalkuli Soru 1", category: 1),
    QuesionToCategory(id: 13, route: "Diskalkuli Soru 2", category: 1),
    QuesionToCategory(id: 14, route: "Diskalkuli Soru 3", category: 1),
    QuesionToCategory(id: 15, route: "Diskalkuli Soru 4", category: 1),
    QuesionToCategory(id: 16, route: "Diskalkuli Soru 5", category: 1),
    QuesionToCategory(id: 17, route: "Diskalkuli Soru 6", category: 1),
    QuesionToCategory(id: 18, route: "Diskalkuli Soru 7", category: 1),
    QuesionToCategory(id: 19, route: "Disleksi Soru 1", category: 2),
    QuesionToCategory(id: 20, route: "Disleksi Soru 2", category: 2),
    QuesionToCategory(id: 21, route: "Disleksi Soru 3", category: 2),
    QuesionToCategory(id: 22, route: "Disleksi Soru 4", category: 2),
    QuesionToCategory(id: 23, route: "Okuma Zamanı", category: 3),
  ];
  late UserRequest? userData;
  bool _isLoading = false;
  List<QuesionToCategory> GetQuestionsFromCategoryID(int id) {
    List<QuesionToCategory> list = [];

    for (int i = 0; i < etkinlikOyunlari.length; i++) {
      if (id == etkinlikOyunlari[i].category) list.add(etkinlikOyunlari[i]);
    }
    return list;
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<UserRequest?> loadData() async {
    String Id = supabase.auth.currentUser?.id ?? " ";
    try {
      var data = await Supabase.instance.client
          .from("Users")
          .select()
          .eq("user_id", Id);
      userData = UserRequest.fromJson(data[0]);
      setState(() {
        _isLoading = true;
      });
    } catch (e) {}

    return userData;
  }

  String? GetTitle(int i) {
    switch (i) {
      case 0:
        return "Disgrafi";
        break;
      case 1:
        return "Diskalkuli";
        break;
      case 2:
        return "Disleksi";
        break;
    }
  }

  Future<List<UserRateResponse>> GetUserRates() async {
    List<UserRateResponse> RateResponse = [];
    final data = await supabase
        .from("Rates")
        .select()
        .eq('user_id', supabase.auth.currentUser!.id);

    for (int i = 0; i < data.length; i++) {
      RequestCategorySuccessRate tempRate =
          RequestCategorySuccessRate.fromJson(data[i]);
      UserRateResponse newRate = UserRateResponse(
          rate: tempRate.successRate, title: GetTitle(tempRate.categoryId!));
      RateResponse.add(newRate);
    }
    return RateResponse;
  }

  void RouteProfilePage() async {
    List<UserRateResponse> RateResponse = await GetUserRates();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilePage(
                  userData: userData,
                  RateResponse: RateResponse,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: _isLoading
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0, top: 0, right: 0, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Hoşgeldin,${userData!.nameSurname!} ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                GestureDetector(
                                  child: Image.asset(userData!.Gender! == 1
                                      ? "assets/images/Icons/male.png"
                                      : "assets/images/Icons/female.png"),
                                  onTap: () => {RouteProfilePage()},
                                )
                              ],
                            ),
                          ),
                          FadeInUp(
                              duration: Duration(milliseconds: 1500),
                              child: makeItem(
                                  image:
                                      'assets/images/Thumbnails/disleksi-thumbnail.webp',
                                  tag: 'red',
                                  context: context,
                                  title: "Disleksi",
                                  counter: 0,
                                  questionList: GetQuestionsFromCategoryID(2))),
                          FadeInUp(
                              duration: Duration(milliseconds: 1600),
                              child: makeItem(
                                  image:
                                      'assets/images/Thumbnails/diskalkuli-thumbail.jpg',
                                  tag: 'blue',
                                  context: context,
                                  title: "Diskalkuli",
                                  counter: 0,
                                  questionList: GetQuestionsFromCategoryID(1))),
                          FadeInUp(
                              duration: Duration(milliseconds: 1700),
                              child: makeItem(
                                  image:
                                      'assets/images/Thumbnails/disgrafi-thumbnail.jpg',
                                  tag: 'white',
                                  context: context,
                                  title: "Disgrafi",
                                  counter: 0,
                                  questionList: GetQuestionsFromCategoryID(0))),
                          FadeInUp(
                              duration: Duration(milliseconds: 1700),
                              child: makeItem(
                                  image:
                                      'assets/images/Thumbnails/metintakibi.jpg',
                                  tag: 'white',
                                  context: context,
                                  title: "Metin Takibi",
                                  counter: 0,
                                  questionList: GetQuestionsFromCategoryID(3))),
                        ],
                      ),
                    ),
                  )),
                ],
              )
            : Stack(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ));
  }

  Widget makeItem({image, tag, context, title, counter, questionList}) {
    return Hero(
      tag: tag,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Questionlist(
                        etkinlikOyunlari: questionList,
                      )));
        },
        child: Container(
          height: 250,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 10,
                    offset: Offset(0, 10))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeInUp(
                            duration: Duration(milliseconds: 1000),
                            child: Text(
                              title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              FadeInUp(
                  duration: Duration(milliseconds: 1200),
                  child: Text(
                    "${counter}/${questionList.length}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
