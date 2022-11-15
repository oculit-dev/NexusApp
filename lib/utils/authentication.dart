import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

//SIGN UP METHOD
  Future<String?> signUp(
      {required String email,
      required String password,
      required String name,
      required String location}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = FirebaseAuth.instance.currentUser;
      user!.updateDisplayName(name);
      user.updatePhotoURL(location);
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }

      // if (email.contains('sjajeju.kr')) {
      //   return null;
      // }
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHODJ
  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future<void> signOut() async {
    // User? user = FirebaseAuth.instance.currentUser;
    // print(user?.photoURL);
    await _auth.signOut();
    print('signout');
  }
}
