// To parse this JSON data, do
//
//     final types = typesFromJson(jsonString);

import 'dart:convert';

List<Types> typesFromJson(String str) =>
    List<Types>.from(json.decode(str).map((x) => Types.fromJson(x)));

String typesToJson(List<Types> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Types {
  final String? typeId;
  final String? typeName;

  Types({
    this.typeId,
    this.typeName,
  });

  factory Types.fromJson(Map<String, dynamic> json) => Types(
        typeId: json["typeID"],
        typeName: json["typeName"],
      );

  Map<String, dynamic> toJson() => {
        "typeID": typeId,
        "typeName": typeName,
      };
}
