import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tasking/src/features/core/models/bid_model.dart';

import '../../../repository/auth_repo/auth_repo.dart';
import '../../../repository/user_repo/user_repo.dart';
import '../models/job_model.dart';

class BidPostController extends GetxController {
  static BidPostController get instance => Get.find();

  final _authRepo = Get.put(AuthRepo());
  final _userRepo = Get.put(UserRepo());

  // TextFormField Controllers To Get Form Data

  final biddername = TextEditingController();
  final location = TextEditingController();
  final askingprice = TextEditingController();
  final bidderdescription = TextEditingController();

  getName() {
    final _userEmail = _authRepo.firebaseUser.value?.email;
    if (_userEmail != null) {
      return _userRepo.getUserName(_userEmail);
    } else {
      return "Unknown";
    }
  }

  //
  getJobDetails(jobId) {
    if (jobId != null) {
      return _userRepo.getBidDetails(jobId);
    } else {
      return "Unknown";
    }
  }

  getAllBids() {
    return _userRepo.getAllBids();
  }

  Future<void> createBidPost(BidModel bidData) async {
    _userRepo.createBidDoc(bidData);
  }
}
