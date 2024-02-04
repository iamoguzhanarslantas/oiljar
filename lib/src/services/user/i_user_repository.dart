import 'package:flutter/material.dart';
import 'package:oiljar/src/models/user_model.dart' show UserModel;

abstract class IUserRepository {
  Future<void> saveUser(UserModel userModel);
  Future<void> readUser(UserModel userModel);
  Future<void> updateUser(UserModel userModel);
  Future<void> deleteUser(UserModel userModel);
  Future<bool> checkIfUserEmailExists(TextEditingController emailController);
  Future<List<UserModel>> getAllUsers();
}
