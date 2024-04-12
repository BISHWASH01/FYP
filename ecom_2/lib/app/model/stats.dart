// To parse this JSON data, do
//
//     final stats = statsFromJson(jsonString);

import 'dart:convert';

Stats statsFromJson(String str) => Stats.fromJson(json.decode(str));

String statsToJson(Stats data) => json.encode(data.toJson());

class Stats {
  final String? membershipIncome;
  final String? propertyIncome;
  final String? totalUsers;
  final String? unverifiedProperty;
  final String? pendingProperty;
  final String? verifiedProperty;
  final String? totalReviews;
  final String? totalMembers;

  Stats({
    this.membershipIncome,
    this.propertyIncome,
    this.totalUsers,
    this.unverifiedProperty,
    this.pendingProperty,
    this.verifiedProperty,
    this.totalReviews,
    this.totalMembers,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        membershipIncome: json["membershipIncome"],
        propertyIncome: json["propertyIncome"],
        totalUsers: json["totalUsers"],
        unverifiedProperty: json["unverifiedProperty"],
        pendingProperty: json["pendingProperty"],
        verifiedProperty: json["verifiedProperty"],
        totalReviews: json["totalReviews"],
        totalMembers: json["totalMembers"],
      );

  Map<String, dynamic> toJson() => {
        "membershipIncome": membershipIncome,
        "propertyIncome": propertyIncome,
        "totalUsers": totalUsers,
        "unverifiedProperty": unverifiedProperty,
        "pendingProperty": pendingProperty,
        "verifiedProperty": verifiedProperty,
        "totalReviews": totalReviews,
        "totalMembers": totalMembers,
      };
}
