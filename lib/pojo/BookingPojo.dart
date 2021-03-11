// To parse this JSON data, do
//
//     final bookingPojo = bookingPojoFromJson(jsonString);

import 'dart:convert';

import 'package:elite_guardians/pojo/Booking.dart';

BookingPojo bookingPojoFromJson(String str) => BookingPojo.fromJson(json.decode(str));

String bookingPojoToJson(BookingPojo data) => json.encode(data.toJson());

class BookingPojo {
  BookingPojo({
    this.bookings,
  });

  Booking bookings;

  factory BookingPojo.fromJson(Map<String, dynamic> json) => BookingPojo(
    bookings: Booking.fromJson(json["bookings"]),
  );

  Map<String, dynamic> toJson() => {
    "bookings": bookings.toJson(),
  };
}