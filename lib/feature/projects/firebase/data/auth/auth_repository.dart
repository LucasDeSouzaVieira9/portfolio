import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:portfolio/feature/projects/firebase/model/user_model.dart';

class AuthRepository {
  Future<UserModel> registration(UserModel user, String password) async {
    final response = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: password);
    return user.copyWith(id: response.user!.uid);
  }

  Future<void> saveUser(UserModel user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(user.id).set(user.toJson());
    await firestore.collection('storage').doc(user.id).set({"images": []});
  }

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }
}
