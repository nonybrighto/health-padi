import 'package:firebase_auth/firebase_auth.dart';

class AuthRemote {
  FirebaseAuth _auth;

  AuthRemote() {
    _auth = FirebaseAuth.instance;
  }

  Future<FirebaseUser> authenticateAnonymously() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      return result.user;
    } catch (error) {
      throw Exception('Failed to authenticate device');
    }
  }

  Future<FirebaseUser> getUser() async {
    return _auth.currentUser();
  }
}
