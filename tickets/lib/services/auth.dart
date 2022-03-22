import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAnon() async {
    try {
      var result = await _auth.signInAnonymously();
      
      print(result);
    } catch (e) {}
  }
}
