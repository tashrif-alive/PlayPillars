import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/auth_repo/auth_repo.dart';
import '../../../repository/user_repo/user_repo.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthRepo());
  final _userRepo = Get.put(UserRepo());

  getUserData() {
    final _userEmail = _authRepo.firebaseUser.value?.email;
    if (_userEmail != null) {
      return _userRepo.getUserDetails(_userEmail);
    } else {
      Get.snackbar("Error", "Login To Continue...");
    }
  }

  getAllUsers() {
    return _userRepo.getAllUsers();
  }
}
