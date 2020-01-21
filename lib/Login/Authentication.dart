import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
String CURRENTUSERID;
abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<FirebaseUser>currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    final AuthResult _user = await _firebaseAuth.signInWithEmailAndPassword(email: email,password: password);
    CURRENTUSERID = _user.user.uid;
    return _user.user.uid;
  }

  @override
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    final AuthResult _user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password));
    CURRENTUSERID = _user.user.uid;
    return _user.user.uid;
  }

  @override
  Future<FirebaseUser> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}