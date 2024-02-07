import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oiljar/src/models/models.dart' show PickerModel;
import 'package:oiljar/src/services/services.dart' show IPickerRepository;

class PickerRepository extends IPickerRepository {
  @override
  Future<void> savePicker(PickerModel pickerModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('pickers')
          .doc(pickerModel.id)
          .set({
        'email': pickerModel.email,
        'username': pickerModel.username,
        'id': pickerModel.id,
        'profile': pickerModel.profileType,
      }).then(
        (value) => debugPrint('User Added'),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> readPicker(PickerModel pickerModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('pickers')
          .doc(pickerModel.id)
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
  Future<void> updatePicker(PickerModel pickerModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('pickers')
          .doc(pickerModel.id)
          .update({
        'email': pickerModel.email,
        'username': pickerModel.username,
        'id': pickerModel.id,
        'profile': pickerModel.profileType,
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
  Future<void> deletePicker(PickerModel pickerModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('pickers')
          .doc(pickerModel.id)
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
  Future<bool> checkIfPickerEmailExists(String? email) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('pickers')
          .where('email', isEqualTo: email)
          .get();
      return result.docs.isNotEmpty;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
