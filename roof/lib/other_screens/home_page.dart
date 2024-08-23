import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roof/other_screens/etkinlik_sorulari_screen.dart';
import 'package:roof/other_screens/giris_sorulari_screen.dart';
import 'package:roof/other_screens/registiration_screen.dart';

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 49, 73),
      body: Stack(
        children: [
          Opacity(
            opacity:
                0.1, // Saydamlık ayarı (0.0 tamamen saydam, 1.0 tamamen opak)
            child: Container(
              width: 500,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.scaleDown, //buraya uygun bir logo yapılması gerek
                  image: AssetImage("assets/logo.png"),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Container(
                  height: height * 0.40,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/denemee.png"))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                      const Text(
                        "            DIXLEARNING",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            color: Color.fromARGB(255, 244, 184, 184)),
                      ),
                      customSizedBox(),
                      TextField(
                        decoration: customInputDecaration("Kullanıcı Adı"),
                        textAlign: TextAlign.center,
                        style: textfieldStyle(),
                      ),
                      customSizedBox(),
                      TextField(
                        obscureText: _isObscure,
                        textAlign: TextAlign.center,
                        decoration: customInputDecaration("Şifre").copyWith(
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
                                  color:
                                      const Color.fromARGB(255, 198, 13, 13)),
                            )),
                      ),
                      customSizedBox(),
                      Center(
                        child: TextButton(
                           onPressed: () {
                            Navigator.push(
                            context,
                             CupertinoPageRoute(builder: (context) => EtkinlikSorulariListScreen()),
                              );
                              },
                          child: Container(
                            height: 50,
                            width: 150,
                            margin: EdgeInsets.symmetric(horizontal: 60),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color.fromARGB(255, 29, 143, 181)),
                            child: Center(
                              child: Text(
                                "Giriş Yap",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      customSizedBox(),
                      Center(
                        child: TextButton(
                            onPressed: () 
                            {
                              Navigator.push(
                            context,
                             CupertinoPageRoute(builder: (context) => RegistrationScreen()),
                              );

                            },
                            child: Text(
                              "Hesap Oluştur",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 43, 112, 224)),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle textfieldStyle() {
    return TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 255, 255, 255));
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

  Widget customSizedBox() => const SizedBox(
        height: 20,
      );

  InputDecoration customInputDecaration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: const Color.fromARGB(255, 107, 107, 107)),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.grey,
        )),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.grey,
        )));
  }
}
