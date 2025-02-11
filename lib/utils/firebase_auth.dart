// Package imports:
import 'package:firebase_auth/firebase_auth.dart';

final firebaseAuth = AuthService();

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future signInAnon() async {
    try {
      final UserCredential credential = await _firebaseAuth.signInAnonymously();
      User? user = credential.user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future getUID() async {
    try {
      final user = _firebaseAuth.currentUser!;
      return user.uid;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
