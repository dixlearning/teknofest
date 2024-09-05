import 'package:flutter/material.dart';

//Giriş soruları tamamlandıktan sonra, kullanıcıya etkinlik sorularını sunacak bir ekran
class EtkinlikSorulariListScreen extends StatelessWidget {
  const EtkinlikSorulariListScreen({super.key});

  final List<String> etkinlikOyunlari = const [
    'Disgrafi Soru 1',
    'Disgrafi Soru 2',
    'Disgrafi Soru 3',
    'Disgrafi Soru 4',
    'Disgrafi Soru 5',
    'Disgrafi Soru 6',
    'Diskalkuli Soru 1',
    'Diskalkuli Soru 2',
    'Diskalkuli Soru 3',
    'Diskalkuli Soru 4',
    'Diskalkuli Soru 5',
    'Diskalkuli Soru 6',
    'Diskalkuli Soru 7',
    'Disleksi Soru 1',
    'Disleksi Soru 2',
    'Disleksi Soru 3',
    'Disleksi Soru 4',
    'Okuma Zamanı'
  ];

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
            title: Text(etkinlikOyunlari[index]),
            onTap: () {
              Navigator.pushNamed(context, etkinlikOyunlari[index]);
            },
          );
        },
      ),
    );
  }
}
