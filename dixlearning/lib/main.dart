import 'package:flutter/material.dart';
import 'package:teknofest/etkinlik_sorulari/metin_takibi.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teknofest/etkinlik_sorulari/disgrafi1.dart';
import 'package:teknofest/etkinlik_sorulari/disgrafi2.dart';
import 'package:teknofest/etkinlik_sorulari/disgrafi3.dart';
import 'package:teknofest/etkinlik_sorulari/disgrafi4.dart';
import 'package:teknofest/etkinlik_sorulari/disgrafi5.dart';
import 'package:teknofest/etkinlik_sorulari/disgrafi6.dart';
import 'package:teknofest/etkinlik_sorulari/diskalkuli1.dart';
import 'package:teknofest/etkinlik_sorulari/diskalkuli2.dart';
import 'package:teknofest/etkinlik_sorulari/diskalkuli3.dart';
import 'package:teknofest/etkinlik_sorulari/diskalkuli4.dart';
import 'package:teknofest/etkinlik_sorulari/diskalkuli5.dart';
import 'package:teknofest/etkinlik_sorulari/diskalkuli6.dart';
import 'package:teknofest/etkinlik_sorulari/diskalkuli7.dart';
import 'package:teknofest/etkinlik_sorulari/disleksi1.dart';
import 'package:teknofest/etkinlik_sorulari/disleksi2.dart';
import 'package:teknofest/etkinlik_sorulari/disleksi3.dart';
import 'package:teknofest/etkinlik_sorulari/disleksi4.dart';
import 'package:teknofest/giris_sorulari/eksik_hece.dart';
import 'package:teknofest/giris_sorulari/giris_harf_eslestir_disleksi.dart';
import 'package:teknofest/giris_sorulari/golge_oyunu.dart';
import 'package:teknofest/giris_sorulari/gorsel_adi.dart';
import 'package:teknofest/giris_sorulari/ilk_harf.dart';
import 'package:teknofest/giris_sorulari/mat_hesaplama.dart';
import 'package:teknofest/giris_sorulari/sayi_oyunu.dart';
import 'package:teknofest/other_functions/game_manager.dart';

import 'package:teknofest/screens/home_page.dart';
import 'package:teknofest/giris_sorulari/bd_sorusu.dart';
import 'package:teknofest/screens/registiration_screen.dart';

// ilk_harf.dart dosyasında rotalar bulunuyor.
// seçenekli oyuna bak. orada da main.dart var
Future<void> main() async {
  //dotenv kütüphanesi ile supabase bağlantısı gerçekleşir. bunun için roof klasörünün altına bakın.
  //.env dosyası varsa ve içinde değerler varsa bir şey yapmanıza gerek yok. Eğer .env dosyası yoksa supabase uygulamasına girin
  //supabase uygulamasında Project settings > API  içerisinde bulunan project url ve project API keys içerisinde bulunan anon ve public ile etiketlenmiş kodu kopyalayıp
  //.env dosyasına yapıştırın. Auth yani oturum açma işlemlerinin ve veritabanının yönetimi supabase üzerinden gerçekleşir.

  await Supabase.initialize(
    url: "https://qzdkjswrplbiymknksxj.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF6ZGtqc3dycGxiaXlta25rc3hqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQ1NTg5MzUsImV4cCI6MjA0MDEzNDkzNX0.syw67FF6IVa-W55dwkx35ynAV5W-LU6joX2EmlHl14g",
  );

  runApp(MyApp());
}

//supabase ile ilgili fonksiyonları kullanmak istiyorsanız aşağıdaki tanımlamayı kullanmanız yeterli. Normalde supabase instance tek seferde
//main üzerinde tanımlanır ve her yerde kullanılır. Yani başk başka sayfalarda Supabase fonksiyonlarını kullanabilmek için tek yapmanız gereken supabase yazmak. supabase kelimesinin üzerine mouse'u getirdiğinizde
//otomatik olarak maini import edecektir
final supabase = Supabase.instance.client; //------------------------------

//--------------------------------------------------------------------
//-----------------------------------------------------------------------
class MyApp extends StatelessWidget {
  MyApp({super.key});
  GameManager _gameManager = GameManager();
  int asd = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teknofest Organizasyonu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        //oturum açma işlemlerinin yapıldığı bölüm
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegistrationScreen(),

        'giris_sorulari/bd_sorusu': (context) =>
            QuizPlay(question: _gameManager.oyunlar[0]),

        'giris_sorulari/eksik_hece': (context) =>
            EksikHeceler(question: _gameManager.oyunlar[1]),

        'giris_sorulari/giris_harf_eslestir_disleksi': (context) =>
            HomePage(question: _gameManager.oyunlar[2]),
        'giris_sorulari/golge_oyunu': (context) =>
            WordShadowMatchGame(question: _gameManager.oyunlar[3]),
        'giris_sorulari/gorsel_adi': (context) =>
            WordFillGame(question: _gameManager.oyunlar[4]),

        '/game': (context) => FillMissingLetter(
            question: _gameManager.oyunlar[
                5]), //ilk harf oyununda hata veriyordu bu satırı ekledim

        'giris_sorulari/ilk_harf': (context) =>
            FillMissingLetter(question: _gameManager.oyunlar[5]),

        'giris_sorulari/mat_hesaplama': (context) =>
            HomePage2(question: _gameManager.oyunlar[6]),
        'giris_sorulari/renk_sorusu': (context) =>
            DiskalkuliEgitimPage(question: _gameManager.oyunlar[7]),
        'giris_sorulari/sayi_oyunu': (context) =>
            DiskalkuliEgitimPage(question: _gameManager.oyunlar[8]),

        //etkinlik sorularının bulunduğu rotalar
        'Disgrafi Soru 1': (context) => const PoemPage(),
        'Disgrafi Soru 2': (context) => const KarisikAylar(),
        'Disgrafi Soru 3': (context) => CumleOlusturma(),
        'Disgrafi Soru 4': (context) => const KarisikRenkler(),
        'Disgrafi Soru 5': (context) => const StartScreen(),
        'Disgrafi Soru 6': (context) => const EmojiQuiz(),
        'Diskalkuli Soru 1': (context) => const ToplamaSayfasi(),
        'Diskalkuli Soru 2': (context) => const CikarmaSayfasi(),
        'Diskalkuli Soru 3': (context) => const MathQuiz(),
        'Diskalkuli Soru 4': (context) => MevsimEslestirmeScreen(),
        'Diskalkuli Soru 5': (context) => const YansimaIsaretlemeOyunu(),
        'Diskalkuli Soru 6': (context) => const CountingGame(),
        'Diskalkuli Soru 7': (context) => const PuzzleGameScreen(),
        'Disleksi Soru 1': (context) => const WordMatchingScreen(),
        'Disleksi Soru 2': (context) => const HomeScreen(),
        'Disleksi Soru 3': (context) => const DyslexiaActivityPage(),
        'Disleksi Soru 4': (context) => Disleksi4(),
        'Metin Takibi': (context) => PointerFollowPage(),
      },
      //home: nigga,
    );
  }
}
