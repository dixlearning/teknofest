import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teknofest/screens/home_page.dart';

class AllinOnboardModel {
  String imgStr;
  String description;
  String titlestr;
  AllinOnboardModel(this.imgStr, this.description, this.titlestr);
}

const kAnimationDuration = Duration(milliseconds: 200);

class OnboardScreen extends StatefulWidget {
  OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int currentIndex = 0;
  final PageController _pageController =
      PageController(); // PageController ekleme

  Color lightgreenshede = Color(0xFFF0FAF6);
  Color lightgreenshede1 = Color(0xFFB2D9CC);
  Color greenshede0 = Color(0xFF66A690);
  Color greenshede1 = Color(0xFF93C9B5);
  Color primarygreen = Color(0xFF1E3A34);
  Color grayshade = Color(0xFF93B3AA);
  Color colorAcent = Color(0xFF78C2A7);
  Color cyanColor = Color(0xFF6D7E6E);
  bool _isLoading = false;
  List<AllinOnboardModel> allinonboardlist = [
    AllinOnboardModel(
        "assets/images/Thumbnails/disk.png",
        "Disgrafi, yazma güçlüğü olarak tanımlanan bir öğrenme bozukluğudur. Bu duruma sahip çocuklar,  yazarken ses veya hece ekleme, atlama ya da yer değiştirme gibi hatalar yapabilirler. Dil bilgisi kurallarını uygulamada, noktalama işaretlerini doğru kullanmada ve yazılı anlatımın netliğini sağlamada güçlük çekerler. Özellikle b, d, t, p, s, z, u, ü, o, ö gibi harfleri yazarken sıklıkla karıştırırlar. ",
        "Disgrafi"),
    AllinOnboardModel(
        "assets/images/Thumbnails/diskalkuli-thumbail.jpg",
        "Diskalkuli, genel bilişsel yetenek ile matematik becerileri arasındaki uyumsuzluk olarak tanımlanır. Bu durum, bireyin dört işlem gibi temel matematik becerilerini ve ölçme gibi işlemleri gerçekleştirmede zorluk yaşamasıyla kendini gösterir.",
        "Diskalkuli"),
    AllinOnboardModel(
        "assets/images/Thumbnails/disleksi-thumbnail.webp",
        "Disleksi, harflerin ve kelimelerin karıştırılması veya tersten algılanmasıyla karakterize edilen bir öğrenme güçlüğüdür. Bu durum, disleksi olan öğrencilerin okuma ve konuşmada zorluk yaşamasına neden olur.",
        "Disleksi"),
  ];

  @override
  void initState() {
    checkSplashData();
    super.initState();
  }

  void checkSplashData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? splashIsViewed = prefs.getBool('splash');
    if (splashIsViewed != null && splashIsViewed) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      setState(() {
        _isLoading = true;
      });
    }
  }

  void SaveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('splash', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(
            top: 100,
          ),
          child: _isLoading
              ? Stack(
                  children: [
                    PageView.builder(
                        controller:
                            _pageController, // PageController'ı kullanma
                        onPageChanged: (value) {
                          setState(() {
                            currentIndex = value;
                          });
                        },
                        itemCount: allinonboardlist.length,
                        itemBuilder: (context, index) {
                          return PageBuilderWidget(
                              title: allinonboardlist[index].titlestr,
                              description: allinonboardlist[index].description,
                              imgurl: allinonboardlist[index].imgStr);
                        }),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.3,
                      left: MediaQuery.of(context).size.width * 0.44,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          allinonboardlist.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                    ),
                    currentIndex < allinonboardlist.length - 1
                        ? Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                currentIndex != 0
                                    ? ElevatedButton(
                                        onPressed: () {
                                          _pageController.previousPage(
                                            duration: kAnimationDuration,
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: Text(
                                          "Geri",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: primarygreen),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: lightgreenshede1,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(20.0),
                                                  bottomRight:
                                                      Radius.circular(20.0))),
                                        ),
                                      )
                                    : Container(),
                                ElevatedButton(
                                  onPressed: () {
                                    _pageController.nextPage(
                                      duration: kAnimationDuration,
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Text(
                                    "İleri",
                                    style: TextStyle(
                                        fontSize: 18, color: primarygreen),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: lightgreenshede1,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            bottomLeft: Radius.circular(20.0))),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.2,
                            left: MediaQuery.of(context).size.width * 0.33,
                            child: ElevatedButton(
                              onPressed: () {
                                SaveData();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Text(
                                "Başla",
                                style: TextStyle(
                                    fontSize: 18, color: primarygreen),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: lightgreenshede1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                            ),
                          ),
                  ],
                )
              : Stack(
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                ),
        ));
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentIndex == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentIndex == index ? primarygreen : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class PageBuilderWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imgurl;
  PageBuilderWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.imgurl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Image.asset(imgurl),
          ),
          const SizedBox(
            height: 20,
          ),
          //Title Text
          Text(title,
              style: TextStyle(
                  color: Color(0xFF1E3A34),
                  fontSize: 24,
                  fontWeight: FontWeight.w700)),
          const SizedBox(
            height: 20,
          ),
          //Description
          Text(description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Color(0xFF1E3A34),
                fontSize: 14,
              ))
        ],
      ),
    );
  }
}
