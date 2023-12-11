import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasking/src/features/core/models/bid_model.dart';

import '../../constants/colors.dart';
import '../../features/auth/models/users_model.dart';
import '../../features/core/models/job_model.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUserDoc(UserModel userData) async {
    await _db
        .collection("Users")
        .doc(userData.id)
        .set(userData.toJson())
    // await _db.collection("Users").add(userData.toJson())
        .whenComplete(
          () => Get.snackbar("Success:", "Your Account Has Been Created",
          icon: Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: TTS_LogoColor,
          borderRadius: 10,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 10),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack),
    )
        .catchError((error, stackTrace) {
      Get.snackbar(
        "Error:",
        "Something Went Wrong! Try Again",
        icon: Icon(Icons.error_outline_sharp, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TTS_DangerColor,
        borderRadius: 10,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 10),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      print(error.toString());
    });
  }

  // Fetch User Details
  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((user) => UserModel.fromDatabase(user)).single;
    return userData;
  }

  // Fetch User Name
  Future<UserModel> getUserName(String email) async {
    final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((user) => UserModel.fromDatabase(user)).single;
    return userData;
  }

  // Fetch All Users
  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs.map((user) => UserModel.fromDatabase(user)).toList();
    return userData;
  }

  // Create Job Post

  createJobDoc(JobModel jobData) async {
    await _db
        .collection("Jobs")
        .doc(jobData.id)
        .set(jobData.toJson())
    // await _db.collection("Users").add(userData.toJson())
        .whenComplete(
          () => Get.snackbar("Success:", "Your Job Has Been Posted",
          icon: Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: TTS_LogoColor,
          borderRadius: 10,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 10),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack),
    )
        .catchError((error, stackTrace) {
      Get.snackbar(
        "Error:",
        "Something Went Wrong! Try Again",
        icon: Icon(Icons.error_outline_sharp, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TTS_DangerColor,
        borderRadius: 10,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 10),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      print(error.toString());
    });
  }

  createBidDoc(BidModel bidData) async {
    await _db
        .collection("Bids")
        .doc(bidData.id)
        .set(bidData.toJson())
    // await _db.collection("Users").add(userData.toJson())
        .whenComplete(
          () => Get.snackbar("Success:", "your bid is done",
          icon: Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: TTS_LogoColor,
          borderRadius: 10,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 10),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack),
    )
        .catchError((error, stackTrace) {
      Get.snackbar(
        "Error:",
        "Something Went Wrong! Try Again",
        icon: Icon(Icons.error_outline_sharp, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TTS_DangerColor,
        borderRadius: 10,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 10),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      print(error.toString());
    });
  }

  // Fetch Job Details
  Future<JobModel> getJobDetails(String jobId) async {
    // final snapshot = await _db.collection("Jobs").where("id", isEqualTo: jobId).get();
    // final snapshot = await _db.collection("Jobs").doc('id jobId').get();
    final snapshot = await _db.collection("Jobs").where(FieldPath.documentId, isEqualTo: jobId).get();
    final jobDetails = snapshot.docs.map((details) => JobModel.fromDatabase(details)).single;
    return jobDetails;
  }

  // Fetch All Jobs
  Future<List<JobModel>> getAllJobs() async {
    final snapshot = await _db.collection("Jobs").get();
    final JobData = snapshot.docs.map((jobs) => JobModel.fromDatabase(jobs)).toList();
    return JobData;


  }
  Future<BidModel> getBidDetails(String bidId) async {
    // final snapshot = await _db.collection("Jobs").where("id", isEqualTo: jobId).get();
    // final snapshot = await _db.collection("Jobs").doc('id jobId').get();
    final snapshot = await _db.collection("Bids").where(FieldPath.documentId, isEqualTo: bidId).get();
    final bidDetails = snapshot.docs.map((details) => BidModel.fromDatabase(details)).single;
    return bidDetails;
  }
  // Fetch All Bids
  Future<List<BidModel>> getAllBids() async {
    final snapshot = await _db.collection("bids").get();
    final bidData = snapshot.docs.map((bids) => BidModel.fromDatabase(bids)).toList();
    return bidData;


  }
}
