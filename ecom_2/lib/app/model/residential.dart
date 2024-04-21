// To parse this JSON data, do
//
//     final residential = residentialFromJson(jsonString);

import 'dart:convert';

List<Residential> residentialFromJson(String str) => List<Residential>.from(
    json.decode(str).map((x) => Residential.fromJson(x)));

String residentialToJson(List<Residential> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Residential {
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
  final String? bedrooms;
  final String? bathrooms;
  final String? size;
  final String? parkingSpaces;

  Residential({
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
    this.bedrooms,
    this.bathrooms,
    this.size,
    this.parkingSpaces,
  });

  factory Residential.fromJson(Map<String, dynamic> json) => Residential(
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
        bedrooms: json["bedrooms"],
        bathrooms: json["bathrooms"],
        size: json["size"],
        parkingSpaces: json["parking_spaces"],
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
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "size": size,
        "parking_spaces": parkingSpaces,
      };
}
