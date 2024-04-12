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
  final String? propertyDescription;
  final String? price;
  final String? isInStock;
  final String? imageUrl;
  final String? userId;
  final String? isVerified;
  final String? catId;
  final String? title;
  final String? phoneNumber;
  final String? fullName;
  final String? email;
  final String? locationId;
  final String? locationName;

  Property({
    this.propertyId,
    this.propertyName,
    this.propertyDescription,
    this.price,
    this.isInStock,
    this.imageUrl,
    this.userId,
    this.isVerified,
    this.catId,
    this.title,
    this.phoneNumber,
    this.fullName,
    this.email,
    this.locationId,
    this.locationName,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        propertyId: json["propertyID"],
        propertyName: json["propertyName"],
        propertyDescription: json["propertyDescription"],
        price: json["price"],
        isInStock: json["isInStock"],
        imageUrl: json["imageURL"],
        userId: json["userID"],
        isVerified: json["isVerified"],
        catId: json["catID"],
        title: json["title"],
        phoneNumber: json["phoneNumber"],
        fullName: json["fullName"],
        email: json["email"],
        locationId: json["locationID"],
        locationName: json["locationName"],
      );

  Map<String, dynamic> toJson() => {
        "propertyID": propertyId,
        "propertyName": propertyName,
        "propertyDescription": propertyDescription,
        "price": price,
        "isInStock": isInStock,
        "imageURL": imageUrl,
        "userID": userId,
        "isVerified": isVerified,
        "catID": catId,
        "title": title,
        "phoneNumber": phoneNumber,
        "fullName": fullName,
        "email": email,
        "locationID": locationId,
        "locationName": locationName,
      };
}



// // To parse this JSON data, do
// //
// //     final product = productFromJson(jsonString);

// import 'dart:convert';

// List<Property> propertyFromJson(String str) =>
//     List<Property>.from(json.decode(str).map((x) => Property.fromJson(x)));

// String propertyToJson(List<Property> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Property {
//   final String? propertyID;
//   final String? title;
//   final String? propertyDescription;
//   final String? categoryId;
//   final String? imageUrl;
//   final String? isAvailable;
//   final String? price;
//   final String? categoryTitle;
//   String? isVerified;
//   final String? userId;
//   final String? phoneNumber;

//   Property({
//     this.propertyID,
//     this.title,
//     this.propertyDescription,
//     this.categoryId,
//     this.imageUrl,
//     this.isAvailable,
//     this.price,
//     this.categoryTitle,
//     this.isVerified,
//     this.userId,
//     this.phoneNumber,
//   });

//   factory Property.fromJson(Map<String, dynamic> json) => Property(
//         propertyID: json["propertyID"],
//         title: json["propertyName"],
//         propertyDescription: json["propertyDescription"],
//         categoryId: json["catID"],
//         imageUrl: json["imageURL"],
//         isAvailable: json["isInStock"],
//         price: json["price"],
//         categoryTitle: json["title"],
//         isVerified: json["isVerified"],
//         userId: json["userID"],
//         phoneNumber: json["phoneNumber"],
//       );

//   Map<String, dynamic> toJson() => {
//         "propertyID": propertyID,
//         "propertyName": title,
//         "propertyDescription": propertyDescription,
//         "catID": categoryId,
//         "imageURL": imageUrl,
//         "isInStock": isAvailable,
//         "price": price,
//         "title": categoryTitle,
//         "isVerified": isVerified,
//         "userID": userId,
//         "phoneNumber": phoneNumber,
//       };
// }
