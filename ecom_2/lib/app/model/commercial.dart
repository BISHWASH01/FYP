// To parse this JSON data, do
//
//     final commercial = commercialFromJson(jsonString);

import 'dart:convert';

List<Commercial> commercialFromJson(String str) =>
    List<Commercial>.from(json.decode(str).map((x) => Commercial.fromJson(x)));

String commercialToJson(List<Commercial> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Commercial {
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
  final String? floorArea;
  final String? parkingSpaces;
  final String? buildingClass;
  final String? tenantCapacity;
  final String? typeId;
  final String? typeName;

  Commercial({
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
    this.floorArea,
    this.parkingSpaces,
    this.buildingClass,
    this.tenantCapacity,
    this.typeId,
    this.typeName,
  });

  factory Commercial.fromJson(Map<String, dynamic> json) => Commercial(
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
        floorArea: json["floor_area"],
        parkingSpaces: json["parking_spaces"],
        buildingClass: json["building_class"],
        tenantCapacity: json["tenant_capacity"],
        typeId: json["typeID"],
        typeName: json["typeName"],
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
        "floor_area": floorArea,
        "parking_spaces": parkingSpaces,
        "building_class": buildingClass,
        "tenant_capacity": tenantCapacity,
        "typeID": typeId,
        "typeName": typeName,
      };
}
