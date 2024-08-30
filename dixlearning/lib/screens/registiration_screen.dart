import 'package:flutter/material.dart';
import 'package:teknofest/giris_sorulari/eksik_hece.dart';
import 'package:teknofest/screens/home_page.dart';
import 'package:teknofest/supabase/auth.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true; // Şifre görünürlüğünü kontrol eden değişken

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50], // Açık turkuaz arka plan rengi
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
        backgroundColor: const Color(0xFF00796B), // Koyu turkuaz AppBar rengi
        elevation: 0, // Gölgeleri kaldırarak daha düz bir görünüm sağlar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF00796B), // Koyu turkuaz renk
                const Color(0xFF004D40) // Daha koyu turkuaz renk
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Orta hizalama
          children: <Widget>[
            // E-posta Alanı
            _buildTextField(
              controller: _emailController,
              label: 'Email',
              obscureText: false,
            ),
            const SizedBox(height: 20),
            // Şifre Alanı
            _buildTextField(
              controller: _passwordController,
              label: 'Şifre',
              obscureText: _isObscure,
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                  color: Colors.teal[600],
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure; // Şifre görünürlüğünü değiştir
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            // Kaydol Butonu
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;
                await signUp(email, password);
                // Kayıt başarılıysa giriş ekranına yönlendirebilirsin
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const EksikHeceler()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF00796B), // Koyu turkuaz buton rengi
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Yuvarlak köşeler
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0), // Dikey padding
              ),
              child: const Text('Kaydol',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            // Giriş Butonu
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor:
                    const Color(0xFF00796B), // Koyu turkuaz buton rengi
              ),
              child: const Text('Bir hesabınız var mı? Oturum aç.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0), // Yuvarlak köşeler
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4), // Gölge offseti
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              TextStyle(color: Colors.teal[600]), // Turkuaz renkli etiket
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 16.0, horizontal: 20.0), // Padding
          suffixIcon: suffixIcon, // Şifre için göz simgesi
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
