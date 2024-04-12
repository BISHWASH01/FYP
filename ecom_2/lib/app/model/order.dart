// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  final String? orderId;
  final String? userId;
  final String? total;
  final String? status;
  final DateTime? orderDate;
  final String? email;
  final String? fullName;

  Order({
    this.orderId,
    this.userId,
    this.total,
    this.status,
    this.orderDate,
    this.email,
    this.fullName,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["orderID"],
        userId: json["userID"],
        total: json["total"],
        status: json["status"],
        orderDate: json["date"] == null ? null : DateTime.parse(json["date"]),
        email: json["email"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "orderID": orderId,
        "userID": userId,
        "total": total,
        "status": status,
        "date": orderDate?.toIso8601String(),
        "email": email,
        "full_name": fullName,
      };
}
