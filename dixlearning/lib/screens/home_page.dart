import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teknofest/screens/etkinlik_sorulari_screen.dart';
import 'package:teknofest/screens/registiration_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true; // Şifrenin görünürlüğünü kontrol eden değişken

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFE0F7FA), // Açık turkuaz arka plan rengi
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
                      decoration: BoxDecoration(
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
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: AssetImage(""))),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customSizedBox(),
                              TextField(
                                decoration:
                                    customInputDecoration("Kullanıcı Adı"),
                                textAlign: TextAlign.center,
                                style: textfieldStyle(),
                              ),
                              customSizedBox(),
                              TextField(
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
                                  child: Text(
                                    "Şifremi Unuttum",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF00796B)),
                                  ),
                                ),
                              ),
                              customSizedBox(),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            EtkinlikSorulariListScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFF00796B), // Buton rengi
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 80, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    "Giriş Yap",
                                    style: TextStyle(color: Colors.white),
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
                                            RegistrationScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Hesap Oluştur",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF00796B)),
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
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF00796B), // Koyu turkuaz renk
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
      hintStyle: TextStyle(color: const Color.fromARGB(255, 107, 107, 107)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Color(0xFF00796B)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Color(0xFF00796B)),
      ),
    );
  }
}
