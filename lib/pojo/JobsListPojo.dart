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
    this.securityGuard,
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
  int securityGuard;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    userId: json["user_id"],
    destinationLocation: json["destination_location"],
    arrivalLocation: json["arrival_location"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    isAdmin: json["is_admin"],
    securityGuard: json["security_guard"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "destination_location": destinationLocation,
    "arrival_location": arrivalLocation,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "is_admin": isAdmin,
    "security_guard": securityGuard,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
  };
}
