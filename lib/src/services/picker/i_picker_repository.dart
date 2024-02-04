import 'package:flutter/material.dart';
import 'package:oiljar/src/models/models.dart' show PickerModel;

abstract class IPickerRepository {
  Future<void> savePicker(PickerModel pickerModel);
  Future<void> readPicker(PickerModel pickerModel);
  Future<void> updatePicker(PickerModel pickerModel);
  Future<void> deletePicker(PickerModel pickerModel);
  Future<bool> checkIfPickerEmailExists(TextEditingController emailController);
}
