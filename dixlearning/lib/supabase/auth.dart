
import 'package:teknofest/main.dart';

Future<void> signUp(String email, String password) async {
  try {
    await supabase.auth.signUp(email: email, password: password);
  } catch (e) {
    print('Sign up error: $e');
  }
}

Future<void> signIn(String email, String password) async {
  try {
    await supabase.auth.signInWithPassword(email: email, password: password);
  } catch (e) {
    print('Sign in error: $e');
  }
}

Future<void> signOut() async {
  try {
    await supabase.auth.signOut();
  } catch (e) {
    print('Sign out error: $e');
  }
}
