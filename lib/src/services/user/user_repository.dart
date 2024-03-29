import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:oiljar/src/models/user_model.dart' show UserModel;
import 'package:oiljar/src/services/services.dart' show IUserRepository;

class UserRepository extends IUserRepository {
  @override
  Future<void> saveUser(UserModel userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.id)
          .set({
        'email': userModel.email,
        'username': userModel.username,
        'id': userModel.id,
        'profile': userModel.profileType,
        'points': userModel.points,
      }).then(
        (value) => debugPrint('User Saved'),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> readUser(UserModel userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.id)
          .get()
          .then(
        (value) {
          if (value.exists) {
            debugPrint('User Readed');
            debugPrint(value.data().toString());
          } else {
            debugPrint('There is no data');
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> updateUser(UserModel userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.id)
          .update({
        'email': userModel.email,
        'username': userModel.username,
        'id': userModel.id,
        'profile': userModel.profileType,
      }).then(
        (value) {
          debugPrint('User Updated');
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> deleteUser(UserModel userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.id)
          .delete()
          .then(
        (value) {
          debugPrint('User Deleted');
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<bool> checkIfUserEmailExists(String? email) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      return result.docs.isNotEmpty;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((value) => value.docs
              .map(
                (e) => UserModel.fromMap(
                  e.data(),
                ),
              )
              .toList());
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  @override
  Future<void> addPoints(String id, int points) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(id).update({
        'points': FieldValue.increment(points),
      }).then(
        (value) {
          debugPrint('Points Added');
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<int?> getPoints(String id) async {
    try {
      var documentSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(id).get();

      if (documentSnapshot.exists) {
        debugPrint('Points Getted');
        debugPrint(documentSnapshot.data().toString());
        final result = documentSnapshot.data()!.entries.firstWhere(
              (element) => element.key == 'points',
            );
        return result.value as int?;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Future<void> updatePoints(String id, int lastPoints) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(id).update({
        'points': FieldValue.increment(-lastPoints),
      }).then(
        (value) {
          debugPrint('Points Updated');
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
