import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:oiljar/src/services/services.dart' show IAuthRepository;

class AuthRepository extends IAuthRepository {
  @override
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  String? getUserProfileId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
