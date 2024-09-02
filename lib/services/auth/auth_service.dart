import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///Get Current User
  User? getCurrentUser(){
    return _auth.currentUser;
  }

  ///SignIn
  Future<UserCredential> signInWithEmailPwd(String email, password) async {
    try{
      // sign in user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      //save user info
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
          }
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  ///SignUp
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try{
      //create user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      //save user info
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        }
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  ///SignOut
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}