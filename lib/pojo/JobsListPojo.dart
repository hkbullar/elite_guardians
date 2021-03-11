
import 'dart:convert';

import 'package:elite_guardians/pojo/Booking.dart';

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


