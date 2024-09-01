import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fıkra Zamanı',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          PointerFollowPage(), // Scaffold'ı home parametresine yerleştiriyoruz
      routes: {
        '/etkinlik_sorulari': (context) => EtkinlikSorulariScreen(),
      },
    );
  }
}

class PointerFollowPage extends StatefulWidget {
  @override
  _PointerFollowPageState createState() => _PointerFollowPageState();
}

class _PointerFollowPageState extends State<PointerFollowPage>
    with SingleTickerProviderStateMixin {
  final List<String> stories = [
    "Eşeği ile kasabaya alışverişe giden Nasreddin Hoca; kitap, elma, limon gibi birçok ağır şey almış. "
        "Aldıklarını kocaman bir çuvala yerleştirmiş. Çuvalı da sırtına alıp eşeğine binmiş. Yolda giderken "
        "Hoca’yı gören köylüler: \"Ey Hoca, çuvalı niye kendi sırtına aldın?\", diye sormuşlar. Hoca: "
        "\"Ne yapayım? Zavallı hayvan zaten beni taşıyor, çuvalı da ona taşıtmaya gönlüm razı olmadı\", demiş.",
    "Vakti zamanında bir kadının bir keloğlu varmış. Bir gün zibillikte (çöp dökülen yer) oynarken bir tane "
        "nohut bulmuş, bunu alarak hesaplamaya başlamış: Bir nohuttan on nohut, on nohuttan bir ölçek, bir "
        "ölçekten on ölçek olur deyip ölçek nohudu almış ve zengin bir adamın kapısı önüne gelerek durmuş. "
        "Zengin ev sahibi kapıdan çıkarken kapının önünde Keloğlan’ı görmüş. "
        "“Ne istiyorsun?” diye sormuş. Keloğlan, zengin adama: "
        "“Benim beş yüz deve yükü nohudum vardı, Halep’e giderken yolda harabeler bizi soyarak nohutlarımı "
        "aldılar, adamlarımı öldürdüler, elbiselerimi soyup kötü elbiseler giydirdiler, gözümü bağlayıp bir "
        "dağa koydular. Ben de kaçıp buraya geldim,” demiş. Zengin adam, bunu hemen evine götürmüş, bir kat yeni "
        "elbise giydirmiş; beş on gün oturduktan sonra Keloğlan, “Bana izin verin gideyim?” demiş. Zengin adam, "
        "Keloğlan’a bir at vermiş. Keloğlan yola revan olmuş. Günün birinde Halep’e varmış. Halep de tüccarlardan "
        "“beş yüz deve yükü nohudum geliyor” deyin para almış. Bu adam şöyle zengin, böyle zengin diye herkeş "
        "methetmeye başlamış. Bir gün Haleb’in valisi de bunu yemeğe davet etmiş. Bu da daveti kabul etmiş. "
        "Keloğlan hizmetçisine yirmi lira vererek: “Bu paraları Valinin hizmetçilerine dağıt,” demiş. Kendi "
        "önde, hizmetçisi arkada Valinin evine gitmişler. Davetten dönerken Keloğlan’ın hizmetçisi valinin "
        "hizmetçilerinden birine beş lira, diğerine on lira ve ötekilerine de ikişer buçuk lira vermiş. Bir iki "
        "gün sonra vali haber salmış. “Kızımı alıyorsa hiçbir masraf etmeden kendine veririm,” demiş. Bu da "
        "kabul etmiş. Düğünleri kırk gün kırk gece sürmüş. Valinin kızını Keloğlan almış. Bir gün Valinin kızı "
        "hamama gitmek için kocasından beş lira istemiş; kocası da hangi tüccara haber salmışsa kimse para "
        "vermemiş. Gayri Keloğlan bu zamanlarda iyiden iyiye fakir düşmüş; odunları bile kalmamış. Evlerinin "
        "içindeki büyük tut ağacı keserek idare ediyorlarmış. Bir gün yine ağacı keserken ağacın içinden altın "
        "akmaya başlamış. Hemen bir değnek alarak duvara vurmuş. Değnek senini duyan Vali hemen “Ne oluyor?” "
        "diye damadının evine koşmuş. Keloğlan, “Benim beş yüz deve yükü nohudumu satmışlar da karşılığı bana "
        "bu kadar altın getirmişler, onun için dövüşüyorum,” demiş. Parayı toplayarak içeri almışlar. "
        "Keloğlan bir mağaza açıp ticarete başlamış. O tek nohudu sakladığı yerden çıkartarak “Beni zengin eden "
        "bu nohuttur” deyip ağzına atmış. Yiyip içip muradına geçmiş.",
    "Temel aldığı bir daktiloyu bozuk diye geri götürmüş. Satıcı: \"Neresi bozuk dün aldığında sağlamdı."
        "Temel:\"İki tane 'a' yok, 'saat' yazamıyorum",
    "Temel ile Dursun ormanda yürüyorlar. Bir ara Temel Dursun'a sesleniyor:\n "
        "-Dursun ormanın güzelliğine bak! \nDursun:\n"
        "-Ağaçlardan göremiyorum.\n",
    "Günün birinde Hoca Efendi pazara gitmek için eşeğine binip yola koyulmuş."
        "Bir süre gittikten sonra eşek huysuzlanmış ve hoplayıp zıplamaya başlamış."
        "Derken Nasreddin Hoca da eşekten düşüvermiş. Düşmüş düşmesine de çevresine toplanan çocuklar"
        "toplu hâlde bağırmaya başlamışlar:\n “Nasreddin Hoca eşekten düştü, Nasreddin Hoca eşekten düştü.”\n"
        "Hoca, şöyle bir sağına soluna baktıktan sonra büyüklerden kimselerin olmadığını görünce eşe dosta rezil olmamak için;\n"
        "“Çocuklar, eşekten düşmedim, ben zaten inecektim.” deyivermiş."
  ];

  int _currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  late int _currentStoryIndex;

  @override
  void initState() {
    super.initState();
    _currentStoryIndex = 0; // Başlangıçta ilk hikaye
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 80), // Başlangıç hızı
    )..addListener(() {
        setState(() {
          _currentIndex =
              (_animation.value * stories[_currentStoryIndex].length).round();
        });
      });

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startPointer() {
    _controller.reset();
    _controller.forward();
  }

  void _setSpeed(int seconds) {
    _controller.duration = Duration(seconds: seconds);
    _startPointer();
  }

  void _onContinuePressed() {
    if (_currentStoryIndex < stories.length - 1) {
      setState(() {
        _currentStoryIndex++;
        _currentIndex = 0;
        _startPointer();
      });
    } else {
      Navigator.pushNamed(
          context, '/etkinlik_sorulari'); // DIXLEARNING etkinlik ekranına git
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Okuma Zamanı!'),
      ),
      body: Container(
        color: Colors.lightGreen[100],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(bottom: 24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Text(
                    _currentStoryIndex == 0
                        ? 'Nasreddin Hoca Fıkrası'
                        : _currentStoryIndex == 1
                            ? 'Keloğlan Masalı'
                            : _currentStoryIndex == 2
                                ? 'Daktilo Fıkrası'
                                : _currentStoryIndex == 3
                                    ? 'Dursun Ormanda'
                                    : 'Eşekten Düşen Hoca Fıkrası',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'İşaretçiyi takip ederek verilen metni okuyalım.',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 24),
            Expanded(
              child: Container(
                color: Colors.grey[100],
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 24, color: Colors.black),
                      children:
                          _getHighlightedText(stories[_currentStoryIndex]),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _setSpeed(140),
                    child: Text('Yavaş Oku'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _setSpeed(90),
                    child: Text('Orta Hızda Oku'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _setSpeed(50),
                    child: Text('Hızlı Oku'),
                  ),
                )
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _onContinuePressed,
              child: Text('Sıradaki İçin Tıkla!'),
            ),
          ],
        ),
      ),
    );
  }

  List<TextSpan> _getHighlightedText(String text) {
    return text.split('').asMap().entries.map((entry) {
      int idx = entry.key;
      String char = entry.value;
      Color color;

      switch (char) {
        case 'b':
          color = Colors.blue;
          break;
        case 'm':
          color = Colors.green;
          break;
        case 'n':
          color = Colors.pink;
          break;
        case 'u':
          color = Colors.purple;
          break;
        default:
          color = Colors.black;
      }

      return TextSpan(
        text: char,
        style: TextStyle(
          color: color,
          backgroundColor:
              idx < _currentIndex ? Colors.yellow[100] : Colors.transparent,
        ),
      );
    }).toList();
  }
}

class EtkinlikSorulariScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Etkinlik Soruları'),
      ),
      body: Center(
        child: Text(
          'Etkinlik Soruları Ekranı',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
