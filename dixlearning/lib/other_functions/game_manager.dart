import 'dart:math';
//Bu sınıf, oyunları rastgele sırayla sunacak ve oyunlar bittiğinde kullanıcıyı ilgili ekrana yönlendirecek.
class GameManager {
  final List<String> oyunlar = [
    'giris_sorulari/giris_harf_eslestir_disleksi',
    'giris_sorulari/golge_oyunu',
    'giris_sorulari/gorsel_adi',
    'giris_sorulari/ilk_harf',
    'giris_sorulari/mat_hesaplama',
    'giris_sorulari/sayi_oyunu',
  ];

  List<String> _remainingGames = [];

  GameManager() {
    _remainingGames = List.from(oyunlar);
    _remainingGames.shuffle(Random());
  }

  String? getNextGame() {
    if (_remainingGames.isEmpty) return null;
    return _remainingGames.removeAt(0);
  }

  bool hasMoreGames() => _remainingGames.isNotEmpty;
}
