import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../repository/auth_repo/auth_repo.dart';
import '../../../repository/user_repo/user_repo.dart';
import '../models/job_model.dart';

class JobPostController extends GetxController {
  static JobPostController get instance => Get.find();

  final _authRepo = Get.put(AuthRepo());
  final _userRepo = Get.put(UserRepo());

  // TextFormField Controllers To Get Form Data

  final jobTitle = TextEditingController();
  final category = TextEditingController();
  final location = TextEditingController();
  final budget = TextEditingController();
  final description = TextEditingController();
  final additionalInfo = TextEditingController();

  getName() {
    final _userEmail = _authRepo.firebaseUser.value?.email;
    if (_userEmail != null) {
      return _userRepo.getUserName(_userEmail);
    } else {
      return "Unknown";
    }
  }

  getJobDetails(jobId) {
    if (jobId != null) {
      return _userRepo.getJobDetails(jobId);
    } else {
      return "Unknown";
    }
  }

  //
  getAllJobs() {
    return _userRepo.getAllJobs();
  }

  Future<void> createJobPost(JobModel jobData) async {
    _userRepo.createJobDoc(jobData);
  }
}
