import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static Future<bool?> registerUser(
      {required String email, required String password}) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      print(e);
    });
  }

  static Future<User?> loginUser(
      {required String email, required String password}) async {
    try {
      User? user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      if (user != null) {
        print("Login Success");
        return user;
      } else {
        print("Login Faild");
      }
    } catch (e) {
      print(e);
    }
  }
}
