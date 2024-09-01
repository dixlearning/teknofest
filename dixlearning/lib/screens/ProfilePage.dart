import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:teknofest/main.dart';
import 'package:teknofest/screens/ProfilePage.dart';
import 'package:teknofest/screens/ProfilePage.dart';
import 'package:teknofest/screens/home_page.dart';
import 'package:teknofest/screens/registiration_screen.dart';

class UserRateResponse {
  double? rate;
  String? title;
  UserRateResponse({required this.rate, required, this.title});
}

class ProfilePage extends StatefulWidget {
  ProfilePage({required this.userData, required this.RateResponse});
  late UserRequest? userData;
  late List<UserRateResponse> RateResponse;
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState(userData: userData, RateResponse: RateResponse);
  }
}

class ProfilePageState extends State<ProfilePage> {
  ProfilePageState({required this.userData, required this.RateResponse});
  late UserRequest? userData;
  late List<UserRateResponse> RateResponse;

  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hoşgeldin, ${userData!.nameSurname!}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  GestureDetector(
                    child: Image.asset(userData!.Gender! == 1
<<<<<<< HEAD
                        ? "assets/images/Icons/male.png"
                        : "assets/images/Icons/female.png"),
=======
                        ? "assets/images/male.png"
                        : "assets/images/female.png"),
>>>>>>> c7a6ac4072d82b4a9348628300196ac711091cc4
                  )
                ],
              ),
            ),
            // GridView'u Expanded ile sarın
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 sütunlu ızgara
                  crossAxisSpacing: 10.0, // Sütunlar arası boşluk
                  mainAxisSpacing: 10.0, // Satırlar arası boşluk
                ),
                padding: EdgeInsets.all(10.0), // GridView'in etrafındaki boşluk
                itemCount: RateResponse.length, // Toplam öğe sayısı
                itemBuilder: (context, index) {
                  final rate = RateResponse[index];
                  return Column(
                    children: [
                      Center(
                          child: AnimatedCircularChart(
                        size: Size(150, 150),
                        initialChartData: <CircularStackEntry>[
                          new CircularStackEntry(
                            <CircularSegmentEntry>[
                              new CircularSegmentEntry(
                                rate.rate!,
                                Colors.blue[400],
                                rankKey: 'completed',
                              ),
                              new CircularSegmentEntry(
                                100 - rate.rate!,
                                Colors.blueGrey[600],
                                rankKey: 'remaining',
                              ),
                            ],
                            rankKey: 'progress',
                          ),
                        ],
                        chartType: CircularChartType.Radial,
                        edgeStyle: SegmentEdgeStyle.round,
                        holeLabel: rate!.rate!.toStringAsFixed(1) + "%",
                        labelStyle: new TextStyle(
                          color: Colors.blueGrey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                        percentageValues: true,
                      )),
                      Center(
                        child: Text(
                          rate.title!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 100),
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () async {
                          await supabase.auth.signOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                              0xFF00796B), // Koyu turkuaz buton rengi
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12.0), // Yuvarlak köşeler
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          // Dikey padding
                        ),
                        child: const Text('Çıkış Yap',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    )))
          ],
        ));
  }
}
