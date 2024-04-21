// To parse this JSON data, do
//
//     final property = propertyFromJson(jsonString);

import 'dart:convert';

List<Property> propertyFromJson(String str) =>
    List<Property>.from(json.decode(str).map((x) => Property.fromJson(x)));

String propertyToJson(List<Property> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Property {
  final String? propertyId;
  final String? propertyName;
  final String? propertyType;
  final String? typeName;
  final String? propertyDescription;
  final String? price;
  final String? isInStock;
  final String? imageUrl;
  final String? isVerified;
  final String? categoryId;
  final String? categoryName;
  final String? phoneNumber;
  final String? fullName;
  final String? email;
  final String? id;
  final String? name;
  final String? city;
  final String? country;

  Property({
    this.propertyId,
    this.propertyName,
    this.propertyType,
    this.typeName,
    this.propertyDescription,
    this.price,
    this.isInStock,
    this.imageUrl,
    this.isVerified,
    this.categoryId,
    this.categoryName,
    this.phoneNumber,
    this.fullName,
    this.email,
    this.id,
    this.name,
    this.city,
    this.country,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        propertyId: json["propertyID"],
        propertyName: json["propertyName"],
        propertyType: json["propertyType"],
        typeName: json["typeName"],
        propertyDescription: json["propertyDescription"],
        price: json["price"],
        isInStock: json["isInStock"],
        imageUrl: json["imageURL"],
        isVerified: json["isVerified"],
        categoryId: json["categoryID"],
        categoryName: json["categoryName"],
        phoneNumber: json["phoneNumber"],
        fullName: json["fullName"],
        email: json["email"],
        id: json["id"],
        name: json["name"],
        city: json["city"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "propertyID": propertyId,
        "propertyName": propertyName,
        "propertyType": propertyType,
        "typeName": typeName,
        "propertyDescription": propertyDescription,
        "price": price,
        "isInStock": isInStock,
        "imageURL": imageUrl,
        "isVerified": isVerified,
        "categoryID": categoryId,
        "categoryName": categoryName,
        "phoneNumber": phoneNumber,
        "fullName": fullName,
        "email": email,
        "id": id,
        "name": name,
        "city": city,
        "country": country,
      };
}
