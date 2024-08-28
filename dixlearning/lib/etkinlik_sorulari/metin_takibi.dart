import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'İşaretçi Takip Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('İşaretçi Takip Uygulaması'),
        ),
        body: PointerFollowPage(),
      ),
    );
  }
}

class PointerFollowPage extends StatefulWidget {
  @override
  _PointerFollowPageState createState() => _PointerFollowPageState();
}

class _PointerFollowPageState extends State<PointerFollowPage>
    with SingleTickerProviderStateMixin {
  final String text =
      "Eşeği ile kasabaya alışverişe giden Nasreddin Hoca; kitap, elma, limon gibi birçok ağır şey almış. "
      "Aldıklarını kocaman bir çuvala yerleştirmiş. Çuvalı da sırtına alıp eşeğine binmiş. Yolda giderken "
      "Hoca’yı gören köylüler: \"Ey Hoca, çuvalı niye kendi sırtına aldın?\", diye sormuşlar. Hoca: "
      "\"Ne yapayım? Zavallı hayvan zaten beni taşıyor, çuvalı da ona taşıtmaya gönlüm razı olmadı\", demiş.";

  int _currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 80), // Başlangıçta orta hızda
    )..addListener(() {
      setState(() {
        _currentIndex = (_animation.value * text.length).round();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300], // Arka plan koyu gri
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text(
            'İşaretçiyi takip ederek verilen metni okuyunuz.',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _setSpeed(140), // Yavaş
                child: Text('Yavaş Oku'),
              ),
              ElevatedButton(
                onPressed: () => _setSpeed(80), // Orta hızda
                child: Text('Orta Hızda Oku'),
              ),
              ElevatedButton(
                onPressed: () => _setSpeed(30), // Hızlı
                child: Text('Hızlı Oku'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: Container(
              color: Colors.grey[200], // Metin alanının arka planı açık gri
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    children: _getHighlightedText(text),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _getHighlightedText(String text) {
    return text.split('').asMap().entries.map((entry) {
      int idx = entry.key;
      String char = entry.value;
      Color? color;

      switch (char) {
        case 'd':
          color = Colors.red;
          break;
        case 'b':
          color = Colors.blue;
          break;
        case 'm':
          color = Colors.green;
          break;
        case 'n':
          color = Colors.pink[100];
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
          backgroundColor: idx < _currentIndex ? Colors.yellow[100] : Colors.transparent,
        ),
      );
    }).toList();
  }
}
