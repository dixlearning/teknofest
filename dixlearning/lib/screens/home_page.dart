import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teknofest/other_functions/MessageHandler.dart';
import 'package:teknofest/other_functions/game_manager.dart';
import 'package:teknofest/screens/dashboard.dart';
import 'package:teknofest/screens/etkinlik_sorulari_screen.dart';
import 'package:teknofest/screens/registiration_screen.dart';
import 'package:teknofest/supabase/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true; // Şifrenin görünürlüğünü kontrol eden değişken
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GameManager _gameManager = GameManager();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA), // Açık turkuaz arka plan rengi
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Opacity(
                    opacity: 0.2, // Saydamlık ayarı
                    child: Container(
                      width: width * 0.5, // Logonun genişliği artırıldı
                      height: width * 0.5, // Logonun yüksekliği artırıldı
                      margin: EdgeInsets.only(
                          top: height * 0.2), // Logo biraz aşağı kaydırıldı
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover, // Logo uyumu
                          image: AssetImage(
                              "assets/images/giris_ekrani_img/logo.png"),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top:
                          height * 0.25), // İçerikler logonun altında hizalanır
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.30,
                          width: width,
                          // Eksik veya kullanılmayan resim kaynağı kaldırıldı
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customSizedBox(),
                              TextField(
                                controller: _emailController,
                                decoration:
                                    customInputDecoration("Kullanıcı Adı"),
                                textAlign: TextAlign.center,
                                style: textfieldStyle(),
                              ),
                              customSizedBox(),
                              TextField(
                                controller: _passwordController,
                                obscureText: _isObscure,
                                textAlign: TextAlign.center,
                                decoration:
                                    customInputDecoration("Şifre").copyWith(
                                  suffixIcon: buttonOfHide(),
                                ),
                                style: textfieldStyle(),
                              ),
                              customSizedBox(),
                              Center(
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Şifremi Unuttum",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF00796B)),
                                  ),
                                ),
                              ),
                              customSizedBox(),
                              Center(
                                child: SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final email = _emailController.text;
                                      final password = _passwordController.text;
                                      Result<String> result =
                                          await signIn(email, password);
                                      if (result.error != null) {
                                        ResultHandler(
                                            context,
                                            ContentType.failure,
                                            "Oh Snap!",
                                            result.error!);
                                      } else {
                                        ResultHandler(
                                            context,
                                            ContentType.success,
                                            "Success!",
                                            "Başarıyla giriş yaptınız. Yönlendiriliyorsunuz...");
                                        Question? matchQuestion =
                                            await _gameManager.getNextGame();

                                        Future.delayed(
                                            Duration(seconds: 4),
                                            () => {
                                                  if (matchQuestion == null)
                                                    {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Dashboard()))
                                                    }
                                                  else
                                                    {
                                                      Navigator.pushNamed(
                                                          context,
                                                          matchQuestion.Route!)
                                                    }
                                                });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(
                                          0xFF00796B), // Koyu turkuaz buton rengi
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12.0), // Yuvarlak köşeler
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0), // Dikey padding
                                    ),
                                    child: const Text(
                                      "Giriş Yap",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              customSizedBox(),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const RegistrationScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Hesap Oluştur",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF00796B)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle textfieldStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color(0xFF00796B), // Koyu turkuaz renk
    );
  }

  IconButton buttonOfHide() {
    return IconButton(
      icon: Icon(
        _isObscure ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey,
      ),
      onPressed: () {
        setState(() {
          _isObscure = !_isObscure; // Şifre görünürlüğünü değiştir
        });
      },
    );
  }

  Widget customSizedBox() => const SizedBox(height: 20);

  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Color.fromARGB(255, 107, 107, 107)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Color(0xFF00796B)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Color(0xFF00796B)),
      ),
    );
  }
}
