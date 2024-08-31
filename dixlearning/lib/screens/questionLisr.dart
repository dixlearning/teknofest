import 'package:flutter/material.dart';
import 'package:teknofest/screens/dashboard.dart';

//Giriş soruları tamamlandıktan sonra, kullanıcıya etkinlik sorularını sunacak bir ekran
class Questionlist extends StatelessWidget {
  Questionlist({super.key, required this.etkinlikOyunlari});
  List<QuesionToCategory> etkinlikOyunlari;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etkinlik Sorulari'),
      ),
      body: ListView.builder(
        itemCount: etkinlikOyunlari.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(etkinlikOyunlari[index].route!),
            onTap: () {
              Navigator.pushNamed(context, etkinlikOyunlari[index].route!);
            },
          );
        },
      ),
    );
  }
}
