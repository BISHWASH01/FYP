// To parse this JSON data, do
//
//     final stats = statsFromJson(jsonString);

import 'dart:convert';

Stats statsFromJson(String str) => Stats.fromJson(json.decode(str));

String statsToJson(Stats data) => json.encode(data.toJson());

class Stats {
  final String? membershipIncome;
  final dynamic propertyIncome;
  final String? totalUsers;
  final String? unverifiedProperty;
  final String? pendingProperty;
  final String? verifiedProperty;
  final String? totalReviews;
  final String? totalMembers;
  final List<TopCategory>? topCategories;

  Stats({
    this.membershipIncome,
    this.propertyIncome,
    this.totalUsers,
    this.unverifiedProperty,
    this.pendingProperty,
    this.verifiedProperty,
    this.totalReviews,
    this.totalMembers,
    this.topCategories,
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
        topCategories: json["topCategories"] == null
            ? []
            : List<TopCategory>.from(
                json["topCategories"]!.map((x) => TopCategory.fromJson(x))),
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
        "topCategories": topCategories == null
            ? []
            : List<dynamic>.from(topCategories!.map((x) => x.toJson())),
      };
}

class TopCategory {
  final String? title;
  final dynamic totalProperties;
  final double? percentage;
  final int? categoryId;
  final String? category;

  TopCategory({
    this.title,
    this.totalProperties,
    this.percentage,
    this.categoryId,
    this.category,
  });

  factory TopCategory.fromJson(Map<String, dynamic> json) => TopCategory(
        title: json["title"],
        totalProperties: json["total_properties"],
        percentage: json["percentage"]?.toDouble(),
        categoryId: json["category_id"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "total_properties": totalProperties,
        "percentage": percentage,
        "category_id": categoryId,
        "category": category,
      };
}
