// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:calculations/modles/ingredient.dart';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  List<Recipe> data;
  String message;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        data: List<Recipe>.from(json["data"].map((x) => Recipe.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Recipe {
  Recipe(
      {this.id,
      this.userId,
      this.title,
      this.note,
      this.price,
      this.weight,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.ingredients,
      this.comments,
      this.weights,
      this.user});

  int id;
  String userId;
  String title;
  String note;
  String price;
  String weight;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  List<Ing> ingredients;
  List<Comment> comments;
  User user;
  String weights;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        note: json["note"],
        price: json["price"],
        weight: json["weight"],
        status: json["status"],
        weights:json['weights'],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        ingredients:
            List<Ing>.from(json["ingredients"].map((x) => Ing.fromJson(x))),
        user: User.fromJson(json["user"]),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "note": note,
        "price": price,
        "weight": weight,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "ingredients": List<Ing>.from(ingredients.map((x) => x.toJson())),
        "user": user.toJson(),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    this.id,
    this.userId,
    this.parentId,
    this.body,
    this.commentableId,
    this.commentableType,
    this.createdAt,
    this.updatedAt,
    this.replies,
  });

  int id;
  String userId;
  String parentId;
  String body;
  String commentableId;
  String commentableType;
  DateTime createdAt;
  DateTime updatedAt;
  List<Comment> replies;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        userId: json["user_id"],
        parentId: json["parent_id"],
        body: json["body"],
        commentableId: json["commentable_id"],
        commentableType: json["commentable_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        replies: json["replies"] == null
            ? null
            : List<Comment>.from(
                json["replies"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "parent_id": parentId,
        "body": body,
        "commentable_id": commentableId,
        "commentable_type": commentableType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "replies": replies == null
            ? null
            : List<dynamic>.from(replies.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
