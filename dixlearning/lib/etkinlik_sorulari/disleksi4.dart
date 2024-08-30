import 'package:flutter/material.dart';

class Disleksi4 extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final String correctText =
      "Dandini dandini danalı bebek Elleri kolları kınalı bebek Benim oğlum nazlı bebek";

  Disleksi4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Birlikte Mani Yazalım!'),
      ),
      body: Container(
        color: Colors.indigo[100],
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Numaralandırılmış heceleri, kutularda bulunan sayılara dikkat edecek şekilde aşağıdaki metin kutusuna yazalım.\n\nDoğru sayıda kelime yazmaya dikkat edelim!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  _buildSyllableItem('1) be'),
                  _buildSyllableItem('2) dini'),
                  _buildSyllableItem('3) alı'),
                  _buildSyllableItem('4) ben'),
                  _buildSyllableItem('5) Dan'),
                  _buildSyllableItem('6) im'),
                  _buildSyllableItem('7) bek'),
                  _buildSyllableItem('8) lum'),
                  _buildSyllableItem('9) kın'),
                  _buildSyllableItem('10) leri'),
                  _buildSyllableItem('11) kol'),
                  _buildSyllableItem('12) lı'),
                  _buildSyllableItem('13) el'),
                  _buildSyllableItem('14) oğ'),
                  _buildSyllableItem('15) ları'),
                  _buildSyllableItem('16) naz'),
                ],
              ),
              const SizedBox(height: 20),
              _buildGrid(),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Maniyi buraya yazalım!',
                ),
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _checkText(context),
                child: const Text('Kontrol Et!'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSyllableItem(String syllable) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.indigo[300],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        syllable,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildGrid() {
    return Column(
      children: [
        _buildGridRow(['5', '2', '', '5', '2']),
        _buildGridRow(['5', '3', '', '1', '7']),
        _buildGridRow(['13', '10', '', '11', '15']),
        _buildGridRow(['9', '3', '', '1', '7']),
        _buildGridRow(['4', '6', '', '14', '8']),
        _buildGridRow(['16', '12', '', '1', '7']),
      ],
    );
  }

  Widget _buildGridRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: numbers.map((num) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                num,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _checkText(BuildContext context) {
    String userInput = _controller.text.trim().toLowerCase();
    String lowerCorrectText = correctText.toLowerCase();

    List<String> userWords = userInput.split(' ');
    List<String> correctWords = lowerCorrectText.split(' ');

    if (userWords.length < 12) {
      _showAlert(context, 'Eksik kelime sayısı.\n12 kelime yazdığına emin ol!');
      return;
    } else if (userWords.length > 12) {
      _showAlert(context, 'Fazla kelime sayısı.\n12 kelime yazdığına emin ol!');
      return;
    }

    List<TextSpan> resultText = [];

    int minLength = userWords.length < correctWords.length
        ? userWords.length
        : correctWords.length;

    for (int i = 0; i < minLength; i++) {
      String userWord = userWords[i];
      String correctWord = correctWords[i];
      if (userWord == correctWord) {
        resultText.add(TextSpan(
          text: '$userWord ',
          style: const TextStyle(color: Colors.green),
        ));
      } else {
        resultText.add(TextSpan(
          text: '$correctWord ',
          style: const TextStyle(color: Colors.red),
        ));
      }
    }

    if (correctWords.length > minLength) {
      for (int i = minLength; i < correctWords.length; i++) {
        resultText.add(TextSpan(
          text: '${correctWords[i]} ',
          style: const TextStyle(color: Colors.red),
        ));
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Kontrol Sonucu'),
        content: SingleChildScrollView(
          child: RichText(
            text: TextSpan(
              children: resultText,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Uyarı!'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
}
