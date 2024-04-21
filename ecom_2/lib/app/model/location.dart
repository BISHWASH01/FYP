// import 'dart:convert';

// List<Location> locationFromJson(String str) =>
//     List<Location>.from(json.decode(str).map((x) => Location.fromJson(x)));

// String locationToJson(List<Location> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Location {
//   final String? locationId;
//   final String? locationName;

//   Location({
//     this.locationId,
//     this.locationName,
//   });

//   factory Location.fromJson(Map<String, dynamic> json) => Location(
//         locationId: json["locationID"],
//         locationName: json["locationName"],
//       );

//   Map<String, dynamic> toJson() => {
//         "locationID": locationId,
//         "locationName": locationName,
//       };
// }
import 'dart:convert';

List<Location> locationFromJson(String str) =>
    List<Location>.from(json.decode(str).map((x) => Location.fromJson(x)));

String locationToJson(List<Location> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Location {
  final String? id;
  final String? name;
  final String? city;
  final String? country;

  Location({
    this.id,
    this.name,
    this.city,
    this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
        city: json["city"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "country": country,
      };
}
