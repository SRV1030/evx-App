// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome with ChangeNotifier {
 
  Welcome({
    this.user,
    this.type,
    this.price,
    this.catchId,
    this.reglink,
    this.regdl,
    this.category,
    this.evttime,
    this.rating,
    this.numReviews,
    this.id,
    this.name,
    this.image,
    this.club,
    this.college,
    this.description,
    this.reviews,
    this.v,
    this.isFavourite = false,
  });

  String user;
  String type;
  int price;
  String catchId;
  String reglink;
  String regdl;
  String category;
  String evttime;
  int rating;
  int numReviews;
  String id;
  String name;
  String image;
  String club;
  String college;
  String description;
  List<dynamic> reviews;
  int v;
  bool isFavourite;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        user: json["user"],
        type: json["type"],
        price: json["price"],
        catchId: json["catchId"],
        reglink: json["reglink"],
        regdl: json["regdl"],
        category: json["category"],
        evttime: json["evttime"],
        rating: json["rating"],
        numReviews: json["numReviews"],
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        club: json["club"],
        college: json["college"],
        description: json["description"],
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "type": type,
        "price": price,
        "catchId": catchId,
        "reglink": reglink,
        "regdl": regdl,
        "category": category,
        "evttime": evttime,
        "rating": rating,
        "numReviews": numReviews,
        "_id": id,
        "name": name,
        "image": image,
        "club": club,
        "college": college,
        "description": description,
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "__v": v,
      };
 
}