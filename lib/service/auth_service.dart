import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
  AuthService._();
  static AuthService authService = AuthService._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithUserEmailAndPassword(String email,String password)
  async {
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
  Future<void> createUserWithEmailAndPassword(String email,String password)
  async {
    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  User? getCurrentUser()
   {
    User? user = firebaseAuth.currentUser;
    if(user!=null)
      {
        log('email ${user.email}');
      }
    return user;
  }

  Future<void> logout()
  async {
    await firebaseAuth.signOut();
  }
}