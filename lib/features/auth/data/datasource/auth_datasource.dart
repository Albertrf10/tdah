import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> register({
    required String email,
    required String password,
    required String username,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;

    if (user != null) {
      // Actualizar el perfil en Firebase Auth
      await user.updateDisplayName(username);
      
      await _db.collection('users').doc(user.uid).set({
        'displayName': username,
        'email': email,
        'createAt': FieldValue.serverTimestamp(),
        'lasLoginAt': FieldValue.serverTimestamp(),
      });
    }

    return user;
  }

  Future<User?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user;
    if (user != null) {
      await _updateLastLogin(user.uid);
    }

    return user;
  }

  Future<User?> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final result = await _auth.signInWithCredential(credential);

    final user = result.user;

    if (user != null) {
      final doc = await _db.collection('users').doc(user.uid).get();

      if (!doc.exists) {
        await _db.collection('users').doc(user.uid).set({
          'displayName': user.displayName ?? '',
          'email': user.email,
          'createAt': FieldValue.serverTimestamp(),
          'lasLoginAt': FieldValue.serverTimestamp(),
        });
      } else {
        await _updateLastLogin(user.uid);
      }
    }

    return user;
  }

  Future<void> _updateLastLogin(String uid) async {
    await _db.collection('users').doc(uid).update({
      'lasLoginAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
