import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  static Future<void> login(String email, String password) async{
    try{
      final ref = FirebaseAuth.instance;
      ref.signInWithEmailAndPassword(email: email, password: password);

    }
     catch (e) {
      print('Error signing in: $e');
    }





  }
}