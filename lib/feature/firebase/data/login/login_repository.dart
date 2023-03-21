import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}
