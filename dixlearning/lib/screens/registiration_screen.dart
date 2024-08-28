import 'package:flutter/material.dart';

import 'package:teknofest/giris_sorulari/renk_sorusu.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(224, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;
                await signUp(email, password);
                // Kayıt başarılıysa giriş ekranına yönlendirebilirsin
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ColorNamingGame()),
                );
              },
              child: const Text('Kaydol'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Bir hesabınız var mı? Oturum aç.'),
            ),
          ],
        ),
      ),
    );
  }
}
