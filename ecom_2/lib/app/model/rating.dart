// To parse this JSON data, do
//
//     final rating = ratingFromJson(jsonString);

import 'dart:convert';

List<Rating> ratingFromJson(String str) =>
    List<Rating>.from(json.decode(str).map((x) => Rating.fromJson(x)));

String ratingToJson(List<Rating> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rating {
  final int? ratingId;
  final int? userId;
  final int? propertyId;
  final int? rating;
  final String? review;
  final DateTime? date;
  final String? fullName;

  Rating({
    this.ratingId,
    this.userId,
    this.propertyId,
    this.rating,
    this.review,
    this.date,
    this.fullName,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        ratingId: json["ratingID"],
        userId: json["userID"],
        propertyId: json["propertyID"],
        rating: json["rating"],
        review: json["review"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "ratingID": ratingId,
        "userID": userId,
        "propertyID": propertyId,
        "rating": rating,
        "review": review,
        "date": date?.toIso8601String(),
        "fullName": fullName,
      };
}
