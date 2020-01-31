import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(email, password) async {
    try {
      AuthResult result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch(e) {
      print(e);
      throw new AuthException(e.code, e.message);
    }
  }

  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }
}
