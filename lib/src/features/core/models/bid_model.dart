import 'package:cloud_firestore/cloud_firestore.dart';

class BidModel {
  final String? id;
  final String biddername;
  final String location;
  final String askingprice;
  final String bidderdescription;

  const BidModel({
    this.id,
    required this.biddername,
    required this.location,
    required this.askingprice,
    required this.bidderdescription,
  });

  toJson() {
    return {
      "Bidder-name": biddername,
      "Location": location,
      "Asking Price": askingprice,
      "Description": bidderdescription,

    };
  }

  factory BidModel.fromDatabase(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final bidData = document.data()!;

    return BidModel(
      id: document.id,
      biddername: bidData["JobTitle"],
      location: bidData["Location"],
      askingprice: bidData["Budget"],
      bidderdescription: bidData["Description"],
    );

    return BidModel(
      id: document.id,
      biddername: "",
      location: "",
      askingprice: "",
      bidderdescription: "",
    );
  }
}
