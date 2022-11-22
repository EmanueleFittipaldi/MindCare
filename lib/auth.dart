import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) 
  async {
    print("Stampo l'user");
    print(currentUser);
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
  }

  Future<void> createNewAccount({
    required String email,
    required String password,
    required String name,
    required String cognome,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

}

