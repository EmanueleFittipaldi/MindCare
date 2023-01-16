import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createNewAccount(
      {required String email, required String password}) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    try {
      credential.user!.sendEmailVerification();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Email non esistente!');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> createNewPatientAccount(
      {required String email, required String password}) async {
    FirebaseApp secondaryApp = await Firebase.initializeApp(
      name: 'SecondaryApp',
      options: Firebase.app().options,
    );

    try {
      UserCredential credential =
          await FirebaseAuth.instanceFor(app: secondaryApp)
              .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        return null;
      } else {
        try {
          await credential.user!.sendEmailVerification();
        } catch (e) {
          Fluttertoast.showToast(msg: 'Email non esistente!');
        }
        return credential.user?.uid;
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: 'Errore inaspettato. Riprova!');
    }

// after creating the account, delete the secondary app as below:
    await secondaryApp.delete();
    return null;
  }

  Future<void> forgottenPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
  }
}
