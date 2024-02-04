import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  User? getCurrentUser();
  String? getUserProfileId();
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> signOut();
}
