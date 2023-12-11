import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  final String? id;
  final String jobTitle;
  final String category;
  final String location;
  final String budget;
  final String description;
  final String? additionalInfo;
  final String? createdBy;
  final DateTime date;

  const JobModel({
    this.id,
    this.additionalInfo,
    required this.date,
    this.createdBy = "Admin",
    this.category = "Other Services...",
    required this.jobTitle,
    required this.location,
    required this.budget,
    required this.description,
  });

  toJson() {
    return {
      "JobTitle": jobTitle,
      "Category": category,
      "Location": location,
      "Budget": budget,
      "Description": description,
      "MoreInfo": additionalInfo,
      "Date": date,
      "CreatedBy": createdBy,
    };
  }

  factory JobModel.fromDatabase(DocumentSnapshot<Map<String, dynamic>> document) {
    final jobdata = document.data()!;

    parseDate(data) {
      if (data == null || data == "") {
        return DateTime.parse("2023-03-12T18:42:49.608466Z");
      } else {
        final timeToMS = data.millisecondsSinceEpoch;
        return DateTime.fromMillisecondsSinceEpoch(timeToMS);
      }
    }

    return JobModel(
      id: document.id,
      jobTitle: jobdata["JobTitle"],
      category: jobdata["Category"],
      location: jobdata["Location"],
      budget: jobdata["Budget"],
      description: jobdata["Description"],
      additionalInfo: jobdata["MoreInfo"],
      date: parseDate(jobdata["Date"]),
      createdBy: "",
    );
  }
}
