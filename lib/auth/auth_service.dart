import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? get currentUser => _auth.currentUser;

  // SignIn method
  static Future<String?> signInAdmin(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return credential.user?.uid;
  }

  // SignOut method
  static Future<void> signOut() async {
    return await _auth.signOut();
  }

// Reset password method
  static Future<void> passwordReset(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }
}
