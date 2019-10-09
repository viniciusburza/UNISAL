// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userId;
  String name;
  String email;
  String profilePictureUrl;

  User({
    this.userId,
    this.name,
    this.email,
    this.profilePictureUrl,
  });

  factory User.fromDocument(DocumentSnapshot document) {
    return User.fromMap(document.data);
  }

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        userId: json["userID"] == null ? null : json["userID"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        profilePictureUrl: json["profilePictureUrl"] == null
            ? null
            : json["profilePictureUrl"],
      );

  Map<String, dynamic> toMap() => {
        "userID": userId == null ? null : userId,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "profilePictureUrl":
            profilePictureUrl == null ? null : profilePictureUrl,
      };
}
