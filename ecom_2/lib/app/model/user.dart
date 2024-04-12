// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  final String? userId;
  final String? email;
  final String? fullName;
  final String? role;
  final String? phoneNumber;
  final String? isMember;

  User({
    this.userId,
    this.email,
    this.fullName,
    this.role,
    this.isMember,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        email: json["email"],
        fullName: json["fullName"],
        role: json["role"],
        phoneNumber: json["phoneNumber"],
        isMember: json["isMember"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "fullName": fullName,
        "role": role,
        "phoneNumber": phoneNumber,
        "isMember": isMember,
      };
}
