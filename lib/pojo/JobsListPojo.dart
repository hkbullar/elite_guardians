// To parse this JSON data, do
//
//     final jobsListPojo = jobsListPojoFromJson(jsonString);

import 'dart:convert';

import 'package:elite_guardians/pojo/User.dart';

JobsListPojo jobsListPojoFromJson(String str) => JobsListPojo.fromJson(json.decode(str));

String jobsListPojoToJson(JobsListPojo data) => json.encode(data.toJson());

class JobsListPojo {
  JobsListPojo({
    this.bookings,
  });

  List<Booking> bookings;

  factory JobsListPojo.fromJson(Map<String, dynamic> json) => JobsListPojo(
    bookings: List<Booking>.from(json["bookings"].map((x) => Booking.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bookings": List<dynamic>.from(bookings.map((x) => x.toJson())),
  };
}

class Booking {
  Booking({
    this.id,
    this.userId,
    this.destinationLocation,
    this.arrivalLocation,
    this.date,
    this.time,
    this.isAdmin,
    this.price,
    this.securityGuard,
    this.acceptReject,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int id;
  int userId;
  String destinationLocation;
  String arrivalLocation;
  DateTime date;
  String time;
  int isAdmin;
  int price;
  int securityGuard;
  int acceptReject;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    userId: json["user_id"],
    destinationLocation: json["destination_location"] == null ? null : json["destination_location"],
    arrivalLocation: json["arrival_location"] == null ? null : json["arrival_location"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    isAdmin: json["is_admin"],
    price: json["price"] == null ? null : json["price"],
    securityGuard: json["security_guard"],
    acceptReject: json["accept_reject"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "destination_location": destinationLocation == null ? null : destinationLocation,
    "arrival_location": arrivalLocation == null ? null : arrivalLocation,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "is_admin": isAdmin,
    "price": price == null ? null : price,
    "security_guard": securityGuard,
    "accept_reject": acceptReject,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
  };
}