import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class LostObject {
  final String finderUserId;
  final String title;
  final String description;
  final String pictureUrl;
  final String date;
  final String loclization;

  LostObject({
    this.finderUserId,
    this.title,
    this.description,
    this.pictureUrl,
    this.date,
    this.loclization,
  });

  factory LostObject.fromDocument(DocumentSnapshot document) {
    return LostObject.fromMap(document.data);
  }

  factory LostObject.fromJson(String str) =>
      LostObject.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LostObject.fromMap(Map<String, dynamic> json) => LostObject(
        finderUserId:
            json["finderUserId"] == null ? null : json["finderUserId"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        pictureUrl: json["pictureUrl"] == null ? null : json["pictureUrl"],
        date: json["date"] == null ? null : json["date"],
        loclization: json["loclization"] == null ? null : json["loclization"],
      );

  Map<String, dynamic> toMap() => {
        "finderUserId": finderUserId == null ? null : finderUserId,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "pictureUrl": pictureUrl == null ? null : pictureUrl,
        "date": date == null ? null : date,
        "loclization": loclization == null ? null : loclization,
      };
}
