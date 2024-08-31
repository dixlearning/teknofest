import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teknofest/main.dart';
import 'package:teknofest/other_functions/MessageHandler.dart';
import 'package:teknofest/screens/registiration_screen.dart';

Future<Result<AuthResponse>> signUp(String email, String password) async {
  try {
    AuthResponse response = await Supabase.instance.client.auth
        .signUp(email: email, password: password);
    return Result(data: response);
  } catch (e) {
    return Result(error: e.toString());
  }
}

Future<Result<String>> UserDetail(UserRequest response) async {
  try {
    await Supabase.instance.client.from("Users").insert(response);
    return Result();
  } catch (e) {
    return Result(error: e.toString());
  }
}

Future<Result<String>> signIn(String email, String password) async {
  try {
    await supabase.auth.signInWithPassword(email: email, password: password);
    return Result();
  } catch (e) {
    return Result(error: e.toString());
  }
}

Future<void> signOut() async {
  try {
    await supabase.auth.signOut();
  } catch (e) {
    print('Sign out error: $e');
  }
}
