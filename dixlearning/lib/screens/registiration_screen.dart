import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
<<<<<<< HEAD
import 'package:teknofest/screens/SplashScreen.dart';
=======
import 'package:teknofest/giris_sorulari/eksik_hece.dart';
>>>>>>> c7a6ac4072d82b4a9348628300196ac711091cc4
import 'package:teknofest/other_functions/MessageHandler.dart';
import 'package:teknofest/screens/home_page.dart';
import 'package:teknofest/supabase/auth.dart';

class UserRequest {
  String? userId;
  String? nameSurname;
  int? Gender;
  UserRequest({this.userId, this.nameSurname, this.Gender});

  UserRequest.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    nameSurname = json['name_surname'];
    Gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name_surname'] = this.nameSurname;
    data['gender'] = this.Gender;
    return data;
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isObscure = true; // Şifrenin görünürlüğünü kontrol eden değişken
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final List<String> items = [
    'Erkek',
    'Kadın',
  ];
  String? selectedGenderValue;

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
      body: SingleChildScrollView(
        // Scroll özelliği eklenerek taşma engellendi
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Orta hizalama
          crossAxisAlignment: CrossAxisAlignment.stretch, // Tam genişlikte
          children: <Widget>[
            _buildTextField(
              controller: _nameController,
              label: 'Name',
              obscureText: false,
            ),
            const SizedBox(height: 20),
            _buildDropdown(
<<<<<<< HEAD
              label: 'Cinsiyet',
            ),
            const SizedBox(height: 20),
=======
                controller: _genderController,
                label: 'Cinsiyet',
                obscureText: false),
            const SizedBox(height: 20),

            // E-posta Alanı
>>>>>>> c7a6ac4072d82b4a9348628300196ac711091cc4
            _buildTextField(
              controller: _emailController,
              label: 'Email',
              obscureText: false,
            ),
            const SizedBox(height: 20),
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
            SizedBox(
<<<<<<< HEAD
              width: double.infinity, // Butonun tam genişlikte olması
=======
              width: 200,
>>>>>>> c7a6ac4072d82b4a9348628300196ac711091cc4
              child: ElevatedButton(
                onPressed: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  final name = _nameController.text;

<<<<<<< HEAD
                  if (email.isEmpty ||
                      password.isEmpty ||
                      name.isEmpty ||
                      selectedGenderValue == null) {
=======
                  if (email == "" ||
                      password == "" ||
                      name == "" ||
                      selectedGenderValue == "") {
>>>>>>> c7a6ac4072d82b4a9348628300196ac711091cc4
                    ResultHandler(context, ContentType.failure, "Oh Snap!",
                        "Lütfen Boşluk Bırakmayınız...");
                    return;
                  }

                  Result<AuthResponse> result = await signUp(email, password);
                  UserRequest request = UserRequest(
                      userId: result.data?.user?.id,
                      nameSurname: name,
                      Gender: selectedGenderValue == "Erkek" ? 1 : 0);
                  if (result.data != null) {
                    Result<String> resultUserdetails =
                        await UserDetail(request);
                  }

                  if (result.error != null) {
                    ResultHandler(context, ContentType.failure, "Oh Snap!",
                        result.error!);
                  } else {
                    ResultHandler(context, ContentType.success, "Success",
                        "Başarıyla kayıt oldunuz. Yönlendiriliyorsunuz...");
                    Future.delayed(
                        Duration(seconds: 2),
                        () => {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
<<<<<<< HEAD
                                  builder: (context) => LoginPage(),
=======
                                  builder: (context) => const LoginPage(),
>>>>>>> c7a6ac4072d82b4a9348628300196ac711091cc4
                                ),
                              )
                            });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF00796B), // Koyu turkuaz buton rengi
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12.0), // Yuvarlak köşeler
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0), // Dikey padding
                ),
                child: const Text('Kaydol',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
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

  Widget _buildDropdown({
<<<<<<< HEAD
    required String label,
  }) {
    return Container(
=======
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    Widget? suffixIcon,
  }) {
    return Container(
      width: double.infinity,
      height: 60,
>>>>>>> c7a6ac4072d82b4a9348628300196ac711091cc4
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
      child: DropdownButton<String>(
        value: selectedGenderValue,
        hint: Text('Cinsiyetinizi Seçin',
            style: TextStyle(color: Colors.teal[600])), // Placeholder
        onChanged: (String? newValue) {
          setState(() {
            selectedGenderValue = newValue;
          });
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(value, style: TextStyle(fontSize: 16))),
          );
        }).toList(),
        underline: SizedBox(), // Alt çizgiyi kaldır
        style: TextStyle(
            fontSize: 16, color: Colors.teal[600]), // Dropdown text stili
      ),
    );
  }
}
