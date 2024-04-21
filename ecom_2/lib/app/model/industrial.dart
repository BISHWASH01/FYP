// To parse this JSON data, do
//
//     final industrial = industrialFromJson(jsonString);

import 'dart:convert';

List<Industrial> industrialFromJson(String str) =>
    List<Industrial>.from(json.decode(str).map((x) => Industrial.fromJson(x)));

String industrialToJson(List<Industrial> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Industrial {
  final String? propertyId;
  final String? propertyName;
  final String? propertyType;
  final String? propertyDescription;
  final String? price;
  final String? isInStock;
  final String? imageUrl;
  final String? userId;
  final String? isVerified;
  final String? categoryId;
  final String? categoryname;
  final String? phoneNumber;
  final String? fullName;
  final String? email;
  final String? id;
  final String? name;
  final String? city;
  final String? country;
  final String? size;
  final String? clearHeight;
  final String? powerSupply;

  Industrial({
    this.propertyId,
    this.propertyName,
    this.propertyType,
    this.propertyDescription,
    this.price,
    this.isInStock,
    this.imageUrl,
    this.userId,
    this.isVerified,
    this.categoryId,
    this.categoryname,
    this.phoneNumber,
    this.fullName,
    this.email,
    this.id,
    this.name,
    this.city,
    this.country,
    this.size,
    this.clearHeight,
    this.powerSupply,
  });

  factory Industrial.fromJson(Map<String, dynamic> json) => Industrial(
        propertyId: json["propertyID"],
        propertyName: json["propertyName"],
        propertyType: json["propertyType"],
        propertyDescription: json["propertyDescription"],
        price: json["price"],
        isInStock: json["isInStock"],
        imageUrl: json["imageURL"],
        userId: json["userID"],
        isVerified: json["isVerified"],
        categoryId: json["categoryID"],
        categoryname: json["categoryname"],
        phoneNumber: json["phoneNumber"],
        fullName: json["fullName"],
        email: json["email"],
        id: json["id"],
        name: json["name"],
        city: json["city"],
        country: json["country"],
        size: json["size"],
        clearHeight: json["clear_height"],
        powerSupply: json["power_supply"],
      );

  Map<String, dynamic> toJson() => {
        "propertyID": propertyId,
        "propertyName": propertyName,
        "propertyType": propertyType,
        "propertyDescription": propertyDescription,
        "price": price,
        "isInStock": isInStock,
        "imageURL": imageUrl,
        "userID": userId,
        "isVerified": isVerified,
        "categoryID": categoryId,
        "categoryname": categoryname,
        "phoneNumber": phoneNumber,
        "fullName": fullName,
        "email": email,
        "id": id,
        "name": name,
        "city": city,
        "country": country,
        "size": size,
        "clear_height": clearHeight,
        "power_supply": powerSupply,
      };
}
