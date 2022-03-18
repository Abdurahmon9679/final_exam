// To parse required this.JSON data, do
//
//     final recipients = recipientsFromJson(jsonString);

import 'dart:convert';

List<Recipients> recipientsFromJson(String str) => List<Recipients>.from(json.decode(str).map((x) => Recipients.fromJson(x)));

String recipientsToJson(List<Recipients> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Recipients {
  Recipients({
    required this.name,
    required this.relationship,
    required this.phoneNumber,
    required this.id,
  });

  String name;
  String relationship;
  String phoneNumber;
  String id;

  factory Recipients.fromJson(Map<String, dynamic> json) => Recipients(
    name: json["name"],
    relationship: json["relationship"],
    phoneNumber: json["phoneNumber"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "relationship": relationship,
    "phoneNumber": phoneNumber,
    "id": id,
  };
}
